package uebung5;

import javax.swing.event.*;
import java.awt.event.*;

public class Controller {

	private Model _model;
	private View _view;
	
	public Controller() {
		_model = new Model();
		_view = new View(this);
		_model.addObserver(_view);
		_view.initateGUI();
		registerActions();
		_view.getFahrButton().addActionListener(new ActionListener(){
			@Override
			public void actionPerformed(ActionEvent arg0) {
				_model.setCelsius(Integer.parseInt(_view.getCelsiusText().getText()));
				_model.convert2Fahrenheit();
				_view.getFahrenheitText().setText(String.valueOf(_model.getFahrenheit()));
				_view.getCelsSlider().setValue(_model.getCelsius());
				_view.getFahrSlider().setValue(_model.getFahrenheit());
			}
		});
		
		_view.getCelsButton().addActionListener(new ActionListener(){
			@Override
			public void actionPerformed(ActionEvent arg0) {
				_model.setFahrenheit(Integer.parseInt(_view.getFahrenheitText().getText()));
				_model.convert2Celsius();
				_view.getCelsiusText().setText(String.valueOf(_model.getCelsius()));
				_view.getCelsSlider().setValue(_model.getCelsius());
				_view.getFahrSlider().setValue(_model.getFahrenheit());
			}
		});
		
		_view.getCelsSlider().addChangeListener(new ChangeListener(){

			@Override
			public void stateChanged(ChangeEvent arg0) {
				_view.getCelsiusText().setText(String.valueOf(_view.getCelsSlider().getValue()));
			}
			
		});
		
		_view.getFahrSlider().addChangeListener(new ChangeListener(){

			@Override
			public void stateChanged(ChangeEvent arg0) {
				_view.getFahrenheitText().setText(String.valueOf(_view.getFahrSlider().getValue()));
			}
			
		});
	}
	
	private void registerActions(){
		_model.setCelsius(0);
	}
}