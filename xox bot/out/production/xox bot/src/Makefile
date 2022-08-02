JFLAGS = -g
JC = javac

.SUFFIXES: .java .class

.java.class:
	$(JC) $(JFLAGS) $*.java

CLASSES = \
    menu/MenuPanel.java \
    menu/Button.java \
    game/GamePanel.java \
    game/Game.java \
    game/BackButton.java \
    game/ResetButton.java \
    Main.java

default: classes

classes: $(CLASSES:.java=.class)

clean:
	$(RM) *.class