package src;

import src.game.GamePanel;
import src.menu.MenuPanel;

import javax.swing.*;
import java.awt.*;

public class Main{

    public static final int width = 1280;
    public static final int height = width/ 4 * 3;
    public static CardLayout cl = new CardLayout();
    public static JPanel panel = new JPanel();

    public static MenuPanel mp;
    public static GamePanel gp;

    public static void main(String[] args){

        JFrame window = new JFrame();
        window.setSize(width, height);
        window.setTitle("XOX");
        window.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        window.setResizable(false);
        window.setLocationRelativeTo(null);
        window.setVisible(true);

        mp = new MenuPanel();
        gp = new GamePanel();

        panel.setLayout(cl);
        panel.add(mp, "0");
        panel.add(gp, "1");

        cl.show(panel, "0");
        window.add(panel);

        window.validate();
    }
}


//  Mert Gürer
//  30.07.2022
//  02.08.2022
