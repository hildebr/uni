package uebung5;

import java.awt.*;
import javax.swing.*;
import java.util.*;

class View implements Observer {
	
	static final int FHR_MIN = -40;
	static final int FHR_MAX = 140;
	static final int FHR_INT = 32;

	static final int CLS_MIN = -40;
	static final int CLS_MAX = 70;
	static final int CLS_INT = 0;

	private JFrame _frame;
	private JPanel _content = new JPanel();
	private JButton _convertLeftButton = new JButton("Convert2Celsius");
	private JButton _convertRightButton = new JButton("Convert2Fahrenheit");
	private JLabel _convertLeftLabel = new JLabel("Fahrenheit");
	private JLabel _convertRightLabel = new JLabel("Celsius");
	private JTextField _convertLeftText = new JTextField(4);
	private JTextField _convertRightText = new JTextField(4);
	private JSlider _celsSlider = new JSlider(JSlider.VERTICAL, CLS_MIN, CLS_MAX, CLS_INT);
	private JSlider _fahrSlider = new JSlider(JSlider.VERTICAL, FHR_MIN, FHR_MAX, FHR_INT);

	public View(Controller controller) {
		_frame = new JFrame();
		_frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		_frame.setTitle("Temperatur Converter");
	}

	public void update(Observable o, Object arg) {
		if (o instanceof Model) {
			Model model = (Model) o;
			int celsius = model.getCelsius();
			int fahrenheit = model.getFahrenheit();
			_convertLeftText.setText(Integer.toString(fahrenheit));
			_convertRightText.setText(Integer.toString(celsius));
			_celsSlider.setValue(celsius);
			_fahrSlider.setValue(fahrenheit);
		}
	}

	public void initateGUI() {
		_frame.setSize(800, 400);
		_frame.setVisible(true);
		_frame.setContentPane(_content);
		_content.setLayout(new FlowLayout());

		_fahrSlider.setMajorTickSpacing(40);
		_fahrSlider.setMinorTickSpacing(5);
		_fahrSlider.setPaintTicks(true);
		_fahrSlider.setPaintLabels(true);

		_celsSlider.setMajorTickSpacing(25);
		_celsSlider.setMinorTickSpacing(5);
		_celsSlider.setPaintTicks(true);
		_celsSlider.setPaintLabels(true);

		_content.add(_fahrSlider);
		_content.add(_convertLeftLabel);
		_content.add(_convertLeftText);
		_content.add(_convertLeftButton);
		_content.add(_convertRightButton);
		_content.add(_convertRightText);
		_content.add(_convertRightLabel);
		_content.add(_celsSlider);
		_convertLeftButton.setBackground(Color.WHITE);
		_convertRightButton.setBackground(Color.WHITE);

		_frame.pack();
	}
	
	public JFrame getFrame(){
		return _frame;
	}
	
	public JTextField getCelsiusText() {
        return _convertRightText;
    }

    public JTextField getFahrenheitText() {
        return _convertLeftText;
    }

    public JSlider getCelsSlider() {
        return _celsSlider;
    }

    public JSlider getFahrSlider() {
        return _fahrSlider;
    }
    
    public JButton getCelsButton() {
        return _convertLeftButton;
    }

    public JButton getFahrButton() {
        return _convertRightButton;
    }
}