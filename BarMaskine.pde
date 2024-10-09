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
    for (String i : pumps) {
      request = request+spacer+"M"+pumps[int(i)]+"="+durations[int(i)];
    }
    println(request);

    String[] lines = loadStrings(request);
  } else {
    println("Not connected");
  }
}

//drive("0-1", "2-4");
