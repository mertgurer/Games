package src.game;

import src.main.Main;

import java.awt.*;

public class Game {

    Graphics2D g2;
    Bot ai;
    boolean bot;
    int turn;
    int maxTurn;
    int[] tiles;

    Game(boolean bot, Graphics2D g2){
        this.g2 = g2;
        this.bot = bot;
        turn = 0;
        maxTurn = 9;
        tiles = new int[9];

        if(bot){
            ai = new Bot(this);
            maxTurn = (ai.start) ? 10 : 9;

            if(ai.start){
                Main.gp.label.setText("Bot chose itself to start. Bot is O");
            }
            else{
                Main.gp.label.setText("Bot chose you to start. You are X");
            }
        }
        else{
            Main.gp.label.setText("X's turn");
        }
    }

    boolean gameCheck(){
        int result = check();
        if(result != 0 || turn == maxTurn){
            end(result);
            return true;
        }
        return false;
    }

    int check(){
        if(tiles[0] == tiles[1] && tiles[1] == tiles[2] && tiles[0] != 0) return tiles[0];
        if(tiles[3] == tiles[4] && tiles[4] == tiles[5] && tiles[3] != 0) return tiles[3];
        if(tiles[6] == tiles[7] && tiles[7] == tiles[8] && tiles[6] != 0) return tiles[6];
        if(tiles[0] == tiles[3] && tiles[3] == tiles[6] && tiles[0] != 0) return tiles[0];
        if(tiles[1] == tiles[4] && tiles[4] == tiles[7] && tiles[1] != 0) return tiles[1];
        if(tiles[2] == tiles[5] && tiles[5] == tiles[8] && tiles[2] != 0) return tiles[2];
        if(tiles[0] == tiles[4] && tiles[4] == tiles[8] && tiles[0] != 0) return tiles[0];
        if(tiles[2] == tiles[4] && tiles[4] == tiles[6] && tiles[2] != 0) return tiles[2];
        return 0;
    }

    void end(int result){
        Main.gp.enabled = false;
        Main.gp.reset.setVisible(true);

        if(bot)
        {
            if(result != 0){
                Main.gp.label.setText("Bot wins :)");
                Main.gp.winCount++;

                if(Main.gp.winCount == 3) Main.gp.label.setText("I hope i am not to hard for you :(");
                if(Main.gp.winCount == 4) Main.gp.label.setText("You are trying right.");
                if(Main.gp.winCount == 5) Main.gp.label.setText("Are all humans this stupid?");
                if(Main.gp.winCount == 7) Main.gp.label.setText("Turning one of my cores off.");
                if(Main.gp.winCount == 10) Main.gp.label.setText("I am only using %2 of my power.");
            }
            else Main.gp.label.setText("Draw!");
        }
        else{
            if(result == 1){
                Main.gp.label.setText("X wins!");
            }
            else if(result == 2){
                Main.gp.label.setText("O wins!");
            }
            else if(result == 0){
                Main.gp.label.setText("Draw!");
            }
        }
    }
}
