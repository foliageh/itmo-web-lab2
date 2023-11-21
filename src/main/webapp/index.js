import {configureFields} from "./shotForm.js";
import {drawPlot} from "./plot.js";
import {clearTable} from "./shotTable.js";

// populateTable()
configureFields()
drawPlot()
document.querySelector('.clear-button').addEventListener('click', function() {
    clearTable()
    drawPlot()
})
