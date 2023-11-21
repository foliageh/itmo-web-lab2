package shots;

import javax.servlet.ServletContext;
import java.util.LinkedList;

public class ShotHistory {
    public static final String CONTEXT_ATTRIBUTE = "shot_history";
    private static ServletContext servletContext;
    private static final LinkedList<Shot> shotHistory = new LinkedList<>();

    public static void initContext(ServletContext servletContext) {
        ShotHistory.servletContext = servletContext;
        servletContext.setAttribute(CONTEXT_ATTRIBUTE, new LinkedList<>());
    }

    synchronized public static void add(Shot shot) {
        shotHistory.addFirst(shot);
        servletContext.setAttribute(CONTEXT_ATTRIBUTE, shotHistory);
    }
}
