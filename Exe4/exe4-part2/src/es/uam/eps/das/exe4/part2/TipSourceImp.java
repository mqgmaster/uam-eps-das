package es.uam.eps.das.exe4.part2;

import es.uam.eps.das.exe4.source.TipSource;

public class TipSourceImp implements TipSource {
	
	public TipSourceImp() {
	}

	@Override
	public String[] getTips() {
		return new String[]{"new tip0", "new tip1", "new tip2"};
	}

}
