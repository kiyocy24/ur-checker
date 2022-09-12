package urchecker

import (
	"context"
	"encoding/json"
	"fmt"
	"log"
	"os"
	"strings"
)

type PubSubMessage struct {
	Data []byte `json:"data"`
}

type Payload struct {
	Urls                []string `json:"urls"`
	KeyWord             string   `json:"keyWord"`
	NotificationMessage string   `json:"notificationMessage"`
}

func UrCheck(ctx context.Context, m PubSubMessage) error {
	var p Payload
	err := json.Unmarshal(m.Data, &p)
	if err != nil {
		log.Fatal(err)
	}

	if p.KeyWord == "" {
		log.Println("key word is not set")
		return nil
	}

	urls := p.Urls
	keyWord := p.KeyWord

	for _, u := range urls {
		s, err := httpRequest(u)
		if err != nil {
			log.Fatal(err)
		}

		if strings.Contains(s, keyWord) {
			notificationMessage := fmt.Sprintf("%s\n%s", p.NotificationMessage, u)
			err := Notification(os.Getenv("LINE_SECRET"), os.Getenv("LINE_TOKEN"), notificationMessage)
			if err != nil {
				return err
			}
		} else {
			log.Printf("key word: %s is not found...", keyWord)
		}
	}

	return nil
}
