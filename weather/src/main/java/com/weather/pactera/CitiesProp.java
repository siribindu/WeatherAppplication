package com.weather.pactera;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Properties;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class CitiesProp {
	
	private static final Logger logger = LoggerFactory.getLogger(CitiesProp.class);

	private static final CitiesProp instance = new CitiesProp();
	
	String[] citiesArray = new String[20];
	private List<String> citiesList = new ArrayList<String>();


	
	public static final CitiesProp getInstance() {
		return instance;
	}
	
	private CitiesProp() {
		loadOnStartUp();
	}
	
	private void loadOnStartUp() {
		Properties prop = new Properties();
		InputStream input = null;
		OutputStream output = null;
		

		try {

			File citiesFile = new File("cities.properties");
			if(!citiesFile.exists()) {

				output = new FileOutputStream("cities.properties");
				
				// set the properties value
				prop.setProperty("Cities", "Sydney,Melbourne,Wollongong,Canberra");
				
				// save properties to project root folder
				prop.store(output, null);
			}
				
			input = new FileInputStream("cities.properties");


			// load a properties file
			prop.load(input);

			// get the property value and print it out
			citiesArray = prop.getProperty("Cities").split(",");
			citiesList = Arrays.asList(citiesArray);
			
		} catch (IOException ex) {

			logger.error("Error loading cities from " , ex);
		} finally {
			if (input != null) {
				try {
					input.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}

		}
	}
	
	
	public void create(String city) {
		citiesList.add(city);
	}
	
	public void delete(String city) {
		citiesList.remove(city);
	}
	
	public List<String> read() {
		return this.citiesList;
	}
}

