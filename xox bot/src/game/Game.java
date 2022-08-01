package src.game;

import src.main.Main;

public class Game {

    Bot ai;
    boolean bot;
    int turn;
    int maxTurn;
    int[] tiles;

    Game(boolean bot){
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

    void gameCheck(){
        int result = check();
        if(result != 0 || turn == maxTurn){
            end(result);
        }
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

        if(bot)
        {
            if(result != 0){
                Main.gp.label.setText("Bot wins :)");
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
