package api.utility.data;

public class GenerateData {
	
	public static String getEmail() {
		String prefix = "Guardian_email";
		String provider = "@tekSchool.us";
		int random = (int) (Math.random() * 1000);
		String email = prefix + random + provider;
		return email;
		
	}
	
	public static String getPhoneNumber() {
		String phoneNumber = "2";
	for (int i = 0; i < 9; i++) {
		phoneNumber += (int) (Math.random() * 10);
	}
		return phoneNumber;
	}
	
	public static String getUserName() {
		String prefix = "Auto_UserN";
		int random = (int)(Math.random() * 1000);
		String Username = prefix.concat(random+"");
		return Username;
	}
	
	public static void main(String[] args) {
		GenerateData data = new GenerateData();
		System.out.println(data.getEmail());
		System.out.println(data.getPhoneNumber());
		System.out.println(data.getUserName());
		
		
	}
  

	
}
