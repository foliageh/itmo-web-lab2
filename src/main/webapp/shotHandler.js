import {showError} from "./notifications.js";
import {addToTable} from "./shotTable.js";
import {drawPoint} from "./plot.js";

export async function handleShots(points) {
    if (!points.length) {
        showError("R is not set!")
        return
    }
    for (const {x, y, r} of points) {
        const response = await fetch(window.location.href, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
            },
            body: new URLSearchParams({x, y, r}),
        })
        const responseData = await response.json()
        if (response.ok) {
            drawPoint(responseData.x, responseData.y, responseData.r, responseData.inArea)
            addToTable(responseData)
        } else if (response.status === 400) showError(responseData.error)
        else showError('Server error.')
    }
}
