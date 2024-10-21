boolean connected = false;
String prefix = "http://";
String ip = "10.194.220.11";
String suffix = "/STRING?DRINK=1";
String spacer = "&";

void drive(String pumpNums, String durationNums) {
  if (connected) {
    String pumps[] = split(pumpNums, '-');
    String durations[] = split(durationNums, '-');
    String request = prefix+ip+suffix;
    for (int i=0;i<pumps.length;i++) {
      request = request+spacer+"M"+pumps[i]+"="+durations[i];
    }
    println(request);

    String[] lines = loadStrings(request);
  } else {
    println("Not connected");
  }
}
