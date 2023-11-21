package servlets;

import com.google.gson.Gson;
import shots.Shot;
import shots.ShotHistory;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalTime;
import java.util.Map;

@WebServlet("/check")
public class AreaCheckServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        long startTime = System.nanoTime();
        LocalTime requestTime = LocalTime.now();

        response.setContentType("application/json");

        String x = request.getParameter("x");
        String y = request.getParameter("y");
        String r = request.getParameter("r");

        if (!checkDataValid(x, y, r)) {
            response.setStatus(400);
            response.getWriter().write(new Gson().toJson(Map.of("error", "Invalid data format.")));
            return;
        }

        Shot shot = new Shot(x, y, r);
        shot.setRequestTime(requestTime);
        shot.setExecutionDuration(System.nanoTime() - startTime);
        ShotHistory.add(shot);

        response.getWriter().write(new Gson().toJson(shot));
    }

    private boolean checkDataValid(String x, String y, String r) {
        try {
            Double.parseDouble(x);
            Double.parseDouble(y);
            Double.parseDouble(r);
            return true;
        } catch (NumberFormatException error) {
            return false;
        }
    }
}
