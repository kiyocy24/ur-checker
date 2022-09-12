package urchecker

import (
	"context"
	"fmt"
	"github.com/GoogleCloudPlatform/functions-framework-go/functions"
	"github.com/cloudevents/sdk-go/v2/event"
	"log"
	"strings"
)

func init() {
	functions.CloudEvent("urChecker", urChecker)
}

type MessagePublishedData struct {
	Message PubSubMessage
}

type PubSubMessage struct {
	Urls    []string `json:"urls"`
	KeyWord string   `json:"keyWord"`
}

func urChecker(ctx context.Context, e event.Event) error {
	var msg MessagePublishedData
	if err := e.DataAs(&msg); err != nil {
		return fmt.Errorf("event.DataAs: %v", err)
	}
	log.Printf("%+v", msg)

	if msg.Message.KeyWord == "" {
		log.Println("key word is not set")
		return nil
	}

	urls := msg.Message.Urls
	keyWord := msg.Message.KeyWord

	for _, u := range urls {
		s, err := httpRequest(u)
		if err != nil {
			log.Fatal(err)
		}

		if strings.Contains(s, keyWord) {
			log.Printf("key word: %s is found!", keyWord)
		} else {
			log.Printf("key word: %s is not found...", keyWord)
		}
	}

	return nil
}
