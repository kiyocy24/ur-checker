package urchecker

import (
	"context"
	"encoding/json"
	"log"
	"strings"
)

type PubSubMessage struct {
	Data []byte `json:"data"`
}

type Payload struct {
	Urls    []string `json:"urls"`
	KeyWord string   `json:"keyWord"`
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
			log.Printf("key word: %s is found", keyWord)
		} else {
			log.Printf("key word: %s is found!", keyWord)
		}
	}

	return nil
}
