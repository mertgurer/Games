package src.main;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;


public class MenuPanel extends JPanel implements ActionListener {

    Button start;
    Button ai;
    Button exit;

    int bWidth = 250;
    int bHeight = 75;
    int x = (Main.width/2) - (bWidth/2);
    int y = (Main.height/2) - (bHeight/2);

    MenuPanel(){
        this.setBackground(new Color(160,152,114));
        this.setSize(Main.width, Main.height);
        this.setLayout(null);

        start = new Button(x, y ,bWidth, bHeight, "Play with Friend");
        start.addActionListener(this);

        y += bHeight + 10;

        ai = new Button(x, y ,bWidth, bHeight, "AI Challenge");
        ai.addActionListener(this);

        y += bHeight + 10;

        exit = new Button(x, y ,bWidth, bHeight, "Exit");
        exit.addActionListener(this);

        this.add(start);
        this.add(ai);
        this.add(exit);

        this.setVisible(true);
    }

    public void paint(Graphics g){
        super.paint(g);
        Graphics2D g2 = (Graphics2D)g;

        int x = 305;
        int y = 300;
        g2.setFont(new Font("Gadugi", Font.BOLD, 128));

        g2.setColor(Color.black);
        g2.drawString("Tic-Tac-Toe", x + 5, y + 5);
        g2.setColor(new Color(70,120,80));
        g2.drawString("Tic-Tac-Toe", x, y);

        g2.dispose();
    }

    @Override
    public void actionPerformed(ActionEvent e) {
        if(e.getSource() == start){
            for(int i=0; i<9; i++){
                Main.gp.tileButton[i].setText("");
            }
            Main.gp.gameRunner(false);
            Main.gp.reset.setVisible(false);
            Main.cl.show(Main.panel, "1");
        }

        if(e.getSource() == ai){
            for(int i=0; i<9; i++){
                Main.gp.tileButton[i].setText("");
            }
            Main.gp.gameRunner(true);
            Main.gp.reset.setVisible(false);
            Main.cl.show(Main.panel, "1");
        }

        if(e.getSource() == exit){
            System.exit(0);
        }
    }
}
