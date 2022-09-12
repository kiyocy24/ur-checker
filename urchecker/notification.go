package urchecker

import (
	"github.com/line/line-bot-sdk-go/v7/linebot"
)

func Notification(secret string, token string, message string) error {
	bot, err := linebot.New(secret, token)
	if err != nil {
		return err
	}

	msg := linebot.NewTextMessage(message)
	_, err = bot.BroadcastMessage(msg).Do()
	if err != nil {
		return err
	}

	return nil
}
