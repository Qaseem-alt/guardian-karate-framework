package api.runner;

import com.intuit.karate.junit5.Karate;

public class SmokeRunner {
	// address for our feature files
	//And tags 
	@Karate.Test
	public Karate runTest() {
		return Karate.run("classpath:features")
				.tags("@Smoke");
	}
	

}
