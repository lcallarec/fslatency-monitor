
static int main (string[] args) {

    var loop = new MainLoop();

    if(args.length < 2){
        stderr.printf("Usage: %s <dir to listen>\n", args[0]);
        return 1;
    }

    var dir = File.new_for_path(args[1]);

    FileMonitor monitor = dir.monitor(GLib.FileMonitorFlags.NONE, null);
    stdout.printf("Monitoring directory : %s\n", dir.get_path());
    stdout.flush();
    monitor.changed.connect ((src, dest, event) => {
        if (event == GLib.FileMonitorEvent.CREATED || event == GLib.FileMonitorEvent.CHANGED) {
            var created_at = read_created_at(src.get_path());
            if (created_at != null) {
                double delta = compute_delta(created_at);
                stdout.printf("latency : %s ms\n", delta.to_string());
                stdout.flush();
            }
        }
    });

    loop.run();

    return 0;
}


double? read_created_at(string filename) {

    var file = File.new_for_path (filename);
    if (false == file.query_exists ()) {
        return null;
    }

    var dis = new DataInputStream(file.read());

    var line = dis.read_line(null);

    if (line != null) line = line.strip();

    if (line != null || line != "") {

        double created_msts = double.parse(line);

        if (created_msts == 0) return null;

        return created_msts;
    }

    return null;
}

double? compute_delta(double created_at) {

    double now = GLib.get_real_time() / 1000;

    double delta = now - created_at;

    return delta;
}
