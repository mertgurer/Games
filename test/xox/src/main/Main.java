package main;

import game.GamePanel;
import menu.MenuPanel;
import window.Window;

public class Main {

    static public Window window;
    static public MenuPanel menu;
    static public GamePanel game;

    public static void main(String[] args) {

        window = new Window();
        menu = new MenuPanel();
        game = new GamePanel();

        window.add(menu);
        window.add(game);
    }
}