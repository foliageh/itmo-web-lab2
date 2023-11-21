package shots;

import java.math.BigDecimal;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;

public class Shot {
    private final String x;
    private final String y;
    private final String r;
    private final boolean inArea;
    private String requestTime;
    private String executionDuration;

    public Shot(String x, String y, String r) {
        this.x = x;
        this.y = y;
        this.r = r;
        this.inArea = checkHit();
    }

    private boolean checkHit() {
        BigDecimal xd = new BigDecimal(x);
        BigDecimal yd = new BigDecimal(y);
        BigDecimal rd = new BigDecimal(r);
        boolean area1_hit = xd.compareTo(BigDecimal.ZERO) <= 0 &&
                yd.compareTo(BigDecimal.ZERO) <= 0 &&
                xd.compareTo(rd.negate().divide(new BigDecimal(2))) >= 0 &&
                yd.compareTo(rd.negate()) >= 0;
        boolean area2_hit = xd.compareTo(BigDecimal.ZERO) <= 0 &&
                yd.compareTo(BigDecimal.ZERO) >= 0 &&
                yd.compareTo(BigDecimal.valueOf(2).multiply(xd.add(rd.divide(new BigDecimal(2))))) <= 0;
        boolean area3_hit = xd.compareTo(BigDecimal.ZERO) >= 0 &&
                yd.compareTo(BigDecimal.ZERO) >= 0 &&
                xd.pow(2).add(yd.pow(2)).compareTo(rd.pow(2)) <= 0;
//        boolean area1_hit = x <= 0 && y <= 0 && x >= -r / 2 && y >= -r;
//        boolean area2_hit = x <= 0 && y >= 0 && y <= 2 * (x + r / 2);
//        boolean area3_hit = x >= 0 && y >= 0 && x * x + y * y <= r * r;
        return area1_hit || area2_hit || area3_hit;
    }

    public String getX() {
        return x;
    }

    public String getY() {
        return y;
    }

    public String getR() {
        return r;
    }

    public boolean isInArea() {
        return inArea;
    }

    public String getRequestTime() {
        return requestTime;
    }

    public String getExecutionDuration() {
        return executionDuration;
    }

    public void setRequestTime(LocalTime time) {
        this.requestTime = time.format(DateTimeFormatter.ofPattern("HH:mm:ss"));
    }

    public void setExecutionDuration(long nanoseconds) {
        this.executionDuration = String.format("%.2f", nanoseconds / 1000000.0) + "ms";
    }
}
