import menu.MenuPanel;
import window.Window;

public class Main {

    static Window window;
    static MenuPanel menu;

    public static void main(String[] args) {

        window = new Window();
        menu = new MenuPanel();

        window.add(menu);
    }
}