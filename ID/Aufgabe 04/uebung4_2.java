package uebung4_2;

import java.awt.*;
import javax.swing.*;
import java.awt.event.*;

//main method to open frame
public class uebung4_2 {
	public static void main(String[] args) {
		JFrame window = new mainFrame();
		window.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		window.setTitle("Bibliothek");
		window.setSize(800, 150);
		window.setVisible(true);
	}
}

// content of main frame
@SuppressWarnings("serial")
class mainFrame extends JFrame {
	private JButton userButton = new JButton("Benutzer einfügen");
	private JButton bookButton = new JButton("Neues Buch hinzufügen");
	private JButton loanBookButton = new JButton("Buch entleihen");
	private JButton returnBookButton = new JButton("Buch zurückgeben");

	private JMenuBar bar = new JMenuBar();

	private JMenu menu1 = new JMenu("Datei");
	private JMenu menu2 = new JMenu("Datenbank");
	private JMenu menu3 = new JMenu("Fenster");
	private JMenu menu4 = new JMenu("Hilfe");

	mainFrame() {
		this.setJMenuBar(bar);
		bar.add(menu1);
		bar.add(menu2);
		bar.add(menu3);
		bar.add(menu4);
		JPanel content = new JPanel();
		content.setLayout(new FlowLayout());
		content.add(userButton);
		content.add(bookButton);
		content.add(loanBookButton);
		content.add(returnBookButton);
		userButton.setBackground(new Color(235,235,235));
		bookButton.setBackground(new Color(235,235,235));
		loanBookButton.setBackground(Color.white);
		returnBookButton.setBackground(Color.white);
		

		this.setContentPane(content);
		this.pack();

		userButton.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				JFrame userWindow = new userFrame();
				userWindow.setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
				userWindow.setTitle("Benutzer hinzufügen");
				userWindow.setSize(600, 200);
				userWindow.setVisible(true);
			}
		});

		bookButton.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				JFrame bookWindow = new bookFrame();
				bookWindow.setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
				bookWindow.setTitle("Buch hinzufügen");
				bookWindow.setSize(550, 200);
				bookWindow.setVisible(true);
			}
		});
	}
}

// content of "add new user" frame
@SuppressWarnings("serial")
class userFrame extends JFrame {
	private JButton addButton = new JButton("Aufnehmen");
	private JButton cancelButton = new JButton("Abbrechen");
	private JTextField name = new HintTextField("Max Mustermann");
	private JTextField id = new HintTextField("1337666");
	private JTextField adress = new HintTextField("Musterstraße 8, 11111 Musterstadt");
	private JTextField birthDate = new HintTextField("dd/mm/yyyy");
	private JTextField addDate = new HintTextField("dd/mm/yyyy");
	private JLabel nameL = new JLabel("Name:");
	private JLabel idL = new JLabel("ID:");
	private JLabel adressL = new JLabel("Adresse:");
	private JLabel birthDateL = new JLabel("Geburtsdatum:");
	private JLabel addDateL = new JLabel("Aufnahmedatum:");
	private JLabel gender = new JLabel("Geschlecht:");
	private JRadioButton male = new JRadioButton("Männlich");
	private JRadioButton female = new JRadioButton("Weiblich");
	private ButtonGroup genderGroup = new ButtonGroup();
	private JPanel genderPanel = new JPanel();

	userFrame() {
		JPanel userContent = new JPanel();
		userContent.setLayout(new GridLayout(7, 2));
		userContent.add(addButton);
		userContent.add(cancelButton);
		addButton.setBackground(Color.GREEN);
		cancelButton.setBackground(Color.RED);
		userContent.add(nameL);
		userContent.add(name);
		userContent.add(idL);
		userContent.add(id);
		userContent.add(adressL);
		userContent.add(adress);
		userContent.add(birthDateL);
		userContent.add(birthDate);
		userContent.add(addDateL);
		userContent.add(addDate);
		userContent.add(gender);
		genderGroup.add(male);
		genderGroup.add(female);
		genderPanel.setLayout(new GridLayout(1, 2));
		genderPanel.add(male);
		genderPanel.add(female);
		userContent.add(genderPanel);
		this.setContentPane(userContent);
		this.pack();

		addButton.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				Window win = SwingUtilities.getWindowAncestor(userContent);
				win.dispose();
			}
		});

		cancelButton.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				Window win = SwingUtilities.getWindowAncestor(userContent);
				win.dispose();
			}
		});
	}
}

// content of "add new user" frame
@SuppressWarnings("serial")
class bookFrame extends JFrame {
	private JButton addButton = new JButton("Aufnehmen");
	private JButton cancelButton = new JButton("Abbrechen");
	private JTextField title = new HintTextField("Musterbuch");
	private JTextField isbn = new HintTextField("1-11111-111-1");
	private JCheckBox loanState = new JCheckBox();
	private JTextField loaner = new HintTextField("Max Mustermann");
	private JComboBox<String> catchword = new JComboBox<String>();
	private JLabel titleL = new JLabel("Titel:");
	private JLabel isbnL = new JLabel("ISBN:");
	private JLabel loanStateL = new JLabel("Verleihstatus:");
	private JLabel loanerL = new JLabel("Entleiher (ID):");
	private JLabel catchwordL = new JLabel("Schlagworte:");

	bookFrame() {
		JPanel userContent = new JPanel();
		userContent.setLayout(new GridLayout(6, 2));
		userContent.add(addButton);
		userContent.add(cancelButton);
		addButton.setBackground(Color.GREEN);
		cancelButton.setBackground(Color.RED);
		userContent.add(titleL);
		userContent.add(title);
		userContent.add(isbnL);
		userContent.add(isbn);
		userContent.add(loanStateL);
		userContent.add(loanState);
		userContent.add(loanerL);
		userContent.add(loaner);
		userContent.add(catchwordL);
		userContent.add(catchword);
		this.setContentPane(userContent);
		this.pack();

		addButton.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				Window win = SwingUtilities.getWindowAncestor(userContent);
				win.dispose();
			}
		});

		cancelButton.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				Window win = SwingUtilities.getWindowAncestor(userContent);
				win.dispose();
			}
		});
	}
}

@SuppressWarnings("serial")
class HintTextField extends JTextField implements FocusListener {

	  private final String hint;
	  private boolean showingHint;

	  public HintTextField(final String hint) {
	    super(hint);
	    this.hint = hint;
	    this.showingHint = true;
	    super.addFocusListener(this);
	    super.setForeground(Color.lightGray);
	  }

	  @Override
	  public void focusGained(FocusEvent e) {
	    if(this.getText().isEmpty()) {
	      super.setText("");
	      showingHint = false;
	      super.setForeground(Color.BLACK);
	    }
	  }
	  @Override
	  public void focusLost(FocusEvent e) {
	    if(this.getText().isEmpty()) {
	      super.setText(hint);
	      showingHint = true;
	      super.setForeground(Color.lightGray);
	    }
	  }

	  @Override
	  public String getText() {
	    return showingHint ? "" : super.getText();
	  }
	}
