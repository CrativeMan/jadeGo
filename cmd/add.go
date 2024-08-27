package cmd

import (
	"fmt"
	"strings"

	"github.com/spf13/cobra"

	"main/db"
)

var addCmd = &cobra.Command{
	Use:   "add",
	Short: "Adds a task to the list",

	Run: func(cmd *cobra.Command, args []string) {
		task := strings.Join(args, " ")

		_, err := db.CreateTask(task)
		if err != nil {
			fmt.Println("Something went wrong:", err.Error())
		}

		fmt.Printf("Added '%s' to your task list\n", task)
	},
}

func init() {
	RootCmd.AddCommand(addCmd)
}
