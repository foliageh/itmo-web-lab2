<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Lab work #2</title>
    <link rel="stylesheet" href="styles.css"/>
    <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/toastify-js/src/toastify.min.css">
    <script type="module" src="index.js"></script>
    <script type="module" src="plot.js"></script>
    <script type="module" src="shotForm.js"></script>
    <script type="module" src="shotHandler.js"></script>
    <script type="module" src="shotTable.js"></script>
    <script defer type="text/javascript" src="https://cdn.jsdelivr.net/npm/toastify-js"></script>
</head>
<body>
<header>
    <div class="student-info">
        <h2>Muratov Mikhail Alexandrovich, P3209</h2>
        <h2>Variant 90812</h2>
    </div>
</header>
<div class="main">
    <div class="control">
        <div class="plot">
            <canvas id="plot__canvas" width="300" height="300"></canvas>
        </div>
        <form class="shot-form">
            <div class="input-block">
                <span class="input-label">X:</span>
                <div class="input-group">
                    <input type="radio" name="x" value="-3" id="x-3" checked required/>
                    <label class="radio-label" for="x-3">-3</label>
                    <input type="radio" name="x" value="-2" id="x-2"/>
                    <label class="radio-label" for="x-2">-2</label>
                    <input type="radio" name="x" value="-1" id="x-1"/>
                    <label class="radio-label" for="x-1">-1</label>
                    <input type="radio" name="x" value="0" id="x0"/>
                    <label class="radio-label" for="x0">0</label>
                    <input type="radio" name="x" value="1" id="x1"/>
                    <label class="radio-label" for="x1">1</label>
                    <input type="radio" name="x" value="2" id="x2"/>
                    <label class="radio-label" for="x2">2</label>
                    <input type="radio" name="x" value="3" id="x3"/>
                    <label class="radio-label" for="x3">3</label>
                    <input type="radio" name="x" value="4" id="x4"/>
                    <label class="radio-label" for="x4">4</label>
                    <input type="radio" name="x" value="5" id="x5"/>
                    <label class="radio-label" for="x5">5</label>
                </div>
            </div>
            <div class="input-block">
                <span class="input-label">Y:</span>
                <div class="input-group">
                    <input
                            name="y"
                            type="text"
                            class="text-input"
                            placeholder="from -5.0 to 3.0"
                            pattern="(?:-5|\+?3)(?:[.,]0+)?|(?:-[43210]|\+?[012])(?:[.,]\d+)?"
                            autofocus
                            required
                    />
                </div>
            </div>
            <div class="input-block">
                <span class="input-label">R:</span>
                <div class="input-group">
                    <label class="checkbox">
                        <input type="checkbox" name="r" value="1"/>
                        <span class="indicator"></span>
                        1
                    </label>
                    <label class="checkbox">
                        <input type="checkbox" name="r" value="1.5"/>
                        <span class="indicator"></span>
                        1.5
                    </label>
                    <label class="checkbox">
                        <input type="checkbox" name="r" value="2"/>
                        <span class="indicator"></span>
                        2
                    </label>
                    <label class="checkbox">
                        <input type="checkbox" name="r" value="2.5"/>
                        <span class="indicator"></span>
                        2.5
                    </label>
                    <label class="checkbox">
                        <input type="checkbox" name="r" value="3"/>
                        <span class="indicator"></span>
                        3
                    </label>
                </div>
            </div>
            <input type="submit" value="Shoot" class="button submit-button"/>
        </form>
        <button class="button clear-button">Clear Table</button>
    </div>
    <div class="table">
        <table id="shot-table">
            <thead>
            <tr>
                <th>№</th>
                <th>Shot</th>
                <th>Time</th>
                <th>Result</th>
            </tr>
            </thead>
            <tbody>
            <c:set var="i" value="${shot_history.size()}"/>
            <c:forEach var="shot" items="${shot_history}">
                <tr>
                    <c:out escapeXml="false" value="<td>${i}</td>"/>
                    <c:out escapeXml="false" value="<td>(${shot.x}; ${shot.y}; ${shot.r})</td>"/>
                    <c:out escapeXml="false" value="<td>${shot.requestTime} (${shot.executionDuration})</td>"/>
                    <c:out escapeXml="false" value="<td>${shot.inArea ? 'In' : 'Out'}</td>"/>
                    <c:set var="i" value="${i-1}"/>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>
</body>
</html>
