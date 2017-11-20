package com.weather.pactera;

import static org.junit.Assert.*;

import org.junit.Test;

import com.weather.pactera.CitiesProp;

public class CitiesDAOTest {

	@Test
	public void testLoadOnStartup() {
		CitiesProp citiesProp = CitiesProp.getInstance();
		assertTrue(citiesProp.read().size() > 0);
	}

}
