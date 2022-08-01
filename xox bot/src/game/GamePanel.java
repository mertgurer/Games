package src.game;

import src.main.Main;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

public class GamePanel extends JPanel implements ActionListener{

    Game game;
    public JButton[] tileButton = new JButton[9];
    JLabel label;
    BackButton back;
    boolean enabled;
    boolean bot;

    public GamePanel(){
        this.setBackground(new Color(160,152,114));
        this.setSize(Main.width, Main.height);
        this.setLayout(null);

        back = new BackButton(10,10, 80,80);
        back.addActionListener(this);

        label = new JLabel();
        label.setFont(new Font("a",Font.BOLD, 50));
        label.setBounds(200,0,Main.width - 400, 100);
        label.setOpaque(true);
        label.setHorizontalAlignment(SwingConstants.CENTER);
        label.setBackground(new Color(158, 151, 100));
        label.setForeground(new Color(70,120,80));

        int x;
        int y = 265;
        for(int i=0; i<3; i++){
            x = 400;
            for(int j=0; j<3; j++){
                tileButton[i*3+j] = new JButton();
                tileButton[i*3+j].setBounds(x, y, 140,140);
                tileButton[i*3+j].setFont(new Font("Dialog", Font.BOLD, 120));
                tileButton[i*3+j].setBorderPainted(false);
                tileButton[i*3+j].setContentAreaFilled(false);
                tileButton[i*3+j].setFocusable(false);
                tileButton[i*3+j].addActionListener(this);
                this.add(tileButton[i*3+j]);
                x += 170;
            }
            y += 170;
        }

        this.add(label);
        this.add(back);
    }

    public void gameRunner(boolean bot){
        this.bot = bot;
        game = new Game(bot);
        enabled = true;
    }

    public void paint(Graphics g){
        super.paint(g);
        Graphics2D g2 = (Graphics2D)g;

        g2.setColor(Color.black);

        // vertical lines
        g2.fillRoundRect(545, 260, 20, 490, 25, 25);
        g2.fillRoundRect(715, 260, 20, 490, 25, 25);
        // horizontal lines
        g2.fillRoundRect(395, 410, 490, 20, 25, 25);
        g2.fillRoundRect(395, 580, 490, 20, 25, 25);

        g2.dispose();
    }

    @Override
    public void actionPerformed(ActionEvent e) {
        boolean valid = false;

        if(e.getSource() == back){
            Main.cl.show(Main.panel, "0");
        }
        if(e.getSource() == tileButton[0] && enabled){
            if(game.tiles[0] == 0){
                if(game.turn % 2 == 0){
                    game.tiles[0] = 1;
                    tileButton[0].setForeground(Color.blue);
                    tileButton[0].setText("X");
                }
                else{
                    game.tiles[0] = 2;
                    tileButton[0].setForeground(Color.red);
                    tileButton[0].setText("O");
                }
                valid = true;
            }
        }
        if(e.getSource() == tileButton[1] && enabled){
            if(game.tiles[1] == 0){
                if(game.turn % 2 == 0){
                    game.tiles[1] = 1;
                    tileButton[1].setForeground(Color.blue);
                    tileButton[1].setText("X");
                }
                else{
                    game.tiles[1] = 2;
                    tileButton[1].setForeground(Color.red);
                    tileButton[1].setText("O");
                }
                valid = true;
            }
        }
        if(e.getSource() == tileButton[2] && enabled){
            if(game.tiles[2] == 0){
                if(game.turn % 2 == 0){
                    game.tiles[2] = 1;
                    tileButton[2].setForeground(Color.blue);
                    tileButton[2].setText("X");
                }
                else{
                    game.tiles[2] = 2;
                    tileButton[2].setForeground(Color.red);
                    tileButton[2].setText("O");
                }
                valid = true;
            }
        }
        if(e.getSource() == tileButton[3] && enabled){
            if(game.tiles[3] == 0){
                if(game.turn % 2 == 0){
                    game.tiles[3] = 1;
                    tileButton[3].setForeground(Color.blue);
                    tileButton[3].setText("X");
                }
                else{
                    game.tiles[3] = 2;
                    tileButton[3].setForeground(Color.red);
                    tileButton[3].setText("O");
                }
                valid = true;
            }
        }
        if(e.getSource() == tileButton[4] && enabled){
            if(game.tiles[4] == 0){
                if(game.turn % 2 == 0){
                    game.tiles[4] = 1;
                    tileButton[4].setForeground(Color.blue);
                    tileButton[4].setText("X");
                }
                else{
                    game.tiles[4] = 2;
                    tileButton[4].setForeground(Color.red);
                    tileButton[4].setText("O");
                }
                valid = true;
            }
        }
        if(e.getSource() == tileButton[5] && enabled){
            if(game.tiles[5] == 0){
                if(game.turn % 2 == 0){
                    game.tiles[5] = 1;
                    tileButton[5].setForeground(Color.blue);
                    tileButton[5].setText("X");
                }
                else{
                    game.tiles[5] = 2;
                    tileButton[5].setForeground(Color.red);
                    tileButton[5].setText("O");
                }
                valid = true;
            }
        }
        if(e.getSource() == tileButton[6] && enabled){
            if(game.tiles[6] == 0){
                if(game.turn % 2 == 0){
                    game.tiles[6] = 1;
                    tileButton[6].setForeground(Color.blue);
                    tileButton[6].setText("X");
                }
                else{
                    game.tiles[6] = 2;
                    tileButton[6].setForeground(Color.red);
                    tileButton[6].setText("O");
                }
                valid = true;
            }
        }
        if(e.getSource() == tileButton[7] && enabled){
            if(game.tiles[7] == 0){
                if(game.turn % 2 == 0){
                    game.tiles[7] = 1;
                    tileButton[7].setForeground(Color.blue);
                    tileButton[7].setText("X");
                }
                else{
                    game.tiles[7] = 2;
                    tileButton[7].setForeground(Color.red);
                    tileButton[7].setText("O");
                }
                valid = true;
            }
        }
        if(e.getSource() == tileButton[8] && enabled){
            if(game.tiles[8] == 0){
                if(game.turn % 2 == 0){
                    game.tiles[8] = 1;
                    tileButton[8].setForeground(Color.blue);
                    tileButton[8].setText("X");
                }
                else{
                    game.tiles[8] = 2;
                    tileButton[8].setForeground(Color.red);
                    tileButton[8].setText("O");
                }
                valid = true;
            }
        }

        if(enabled && valid){
            game.turn++;

            if(bot){
                if(game.turn != game.maxTurn){
                    enabled = false;
                    back.setEnabled(false);
                    game.ai.think();
                }
                else game.gameCheck();
            }
            else{
                String text = (game.turn % 2 == 0) ? "X's turn" : "O's turn";
                label.setText(text);
                game.gameCheck();
            }
        }
    }
}
