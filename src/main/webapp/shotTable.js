const table = document.querySelector('#shot-table tbody')

export function addToTable(data) {
    const row = table.insertRow(0)
    row.insertCell(0).innerHTML = table.rows.length
    row.insertCell(1).innerHTML = `(${data.x}; ${data.y}; ${data.r})`
    row.insertCell(2).innerHTML = `${data.requestTime} (${data.executionDuration})`
    row.insertCell(3).innerHTML = data.inArea ? "In" : "Out"
    // sessionStorage.table = table.innerHTML
}

export function clearTable() {
    table.innerHTML = ''
}

// function populateTable() {
//     document.querySelector('#shot-table tbody').innerHTML = sessionStorage.table ?? ''
// }
