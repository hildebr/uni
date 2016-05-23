package uebung5;

import java.util.Observable;

public class Model extends Observable{
	private int _celsius;
	private int _fahrenheit;
	
	public Model(){
		_celsius = 0;
		_fahrenheit = 32;
	}
	
	public int getCelsius(){
		return _celsius;
	}
	public int getFahrenheit(){
		return _fahrenheit;
	}
	public void setCelsius(int i){
		_celsius = i;
		setChanged();
		notifyObservers();
	}
	public void setFahrenheit(int i){
		_fahrenheit = i;
		setChanged();
		notifyObservers();
	}
	public void convert2Fahrenheit(){
		_fahrenheit = (int)(_celsius * 1.8 + 32);
	}
	public void convert2Celsius(){
		_celsius = (int)((_fahrenheit -32) * 5/9);
	}
}
