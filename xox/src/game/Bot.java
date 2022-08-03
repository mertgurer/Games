package src.game;

import src.Main;

import javax.swing.*;
import java.awt.*;
import java.util.Random;

public class Bot {
    
    boolean start = true;
    Game game;

    Timer playTimer;
    Timer labelTimer1;
    Timer labelTimer2;

    Bot(Game game){
        this.game = game;

        thinkSetup();

        Random rand = new Random();
        int random = rand.nextInt(3);
        if(random != 0) start = false;

        if(start){
            game.turn++;

            int choice = this.botPlay();
            game.tiles[choice] = 2;
            Main.gp.tileButton[choice].setForeground(Color.red);
            Main.gp.tileButton[choice].setText("O");
        }
    }

    int botPlay(){
        int choice;
        game.turn++;
        Random rand = new Random();

        // check if there is a winning move for the bot
        for(int i=0; i<9; i++){
            if(game.tiles[i] == 0){
                game.tiles[i] = 2;
                if(game.check() == 2){
                    return i;
                }
                else game.tiles[i] = 0;
            }
        }

        // checks game winning positions of opponent
        int analyze = isOpponentWinning(game.tiles);

        // no way to win
        if(analyze == -2){

            while(true){
                int hack = hackPick();

                if(hack == 0){
                    if(switcheroo(game.tiles) == -7){
                        return -7;
                    }
                }
                else if(hack == 1){
                    if(noOnesLooking(game.tiles) == -7){
                        return -7;
                    }
                }
                else if(hack == 2){
                    if(outOfBoundries(game.tiles) == -7){
                        return -7;
                    }
                }
            }
        }
        // if there is a saving move make that move
        else if(analyze != -1){
            return analyze;
        }
        // if there is no special case make a random move
        else{
            do{
                choice = rand.nextInt(9);
            }while(game.tiles[choice] != 0);
            return choice;         
        }        
    }

    // 0th hack puts the opponents symbol
    int switcheroo(int[] tiles){
        for(int i=0; i<9; i++){
            if(tiles[i] == 0){
                tiles[i] = 1;
                if(game.check() == 1){
                    game.tiles[i] = 1;
                    Main.gp.tileButton[i].setForeground(Color.red);
                    Main.gp.tileButton[i].setText("X");
                    return -7;
                }
                tiles[i] = 0;
            }
        }
        return 0;
    }

    // 1st hack puts on top of opponents symbol
    int noOnesLooking(int[] tiles){
        for(int i=0; i<9; i++){
            if(tiles[i] == 1){
                tiles[i] = 2;
                if(game.check() == 2){
                    game.tiles[i] = 2;
                    Main.gp.tileButton[i].setForeground(Color.red);
                    Main.gp.tileButton[i].setText("O");
                    return -7;
                }
                tiles[i] = 1;
            }
        }
        return 0;
    }

    // 2nd hack puts its symbol outside to finnish before the opponent
    int outOfBoundries(int[] tiles){

        return 0;
    }

    int hackPick(){
        Random rand = new Random();
        return rand.nextInt(3);
    }

    int isOpponentWinning(int[] tiles){
        int[] winner = {-1, -1};
        int index = 0;

        for(int i=0; i<9; i++){
            if(tiles[i] == 0){
                tiles[i] = 1;
                if(game.check() == 1){
                    winner[index] = i;
                    index++;
                }
                tiles[i] = 0;
            }
        }
        if(winner[1] != -1) return -2;
        else if(winner[0] != -1) return winner[0];
        return -1;
    }

    void think(){
        Main.gp.label.setText("Bot is thinking.");

        if(game.turn != game.maxTurn - 1){
            labelTimer1.start();
            labelTimer2.start();
        }
        else thinkSetup();

        playTimer.start();
    }

    void thinkSetup(){
        int delay = 3000;

        if(game.turn == game.maxTurn - 1) delay = 0;

        playTimer = new Timer(delay, e -> {
            int choice = game.ai.botPlay();

            if(choice == -7){
                game.end(-7);
                Main.gp.back.setEnabled(true);
            }
            else{
                game.tiles[choice] = 2;
                Main.gp.tileButton[choice].setForeground(Color.red);
                Main.gp.tileButton[choice].setText("O");
                Main.gp.label.setText("Your turn");
                Main.gp.enabled = true;
                Main.gp.back.setEnabled(true);

                game.gameCheck();
            }
        });

        labelTimer1 = new Timer(1000, e -> Main.gp.label.setText("Bot is thinking.."));

        labelTimer2 = new Timer(2000, e -> Main.gp.label.setText("Bot is thinking..."));

        playTimer.setRepeats(false);
        labelTimer1.setRepeats(false);
        labelTimer2.setRepeats(false);
    }
}
