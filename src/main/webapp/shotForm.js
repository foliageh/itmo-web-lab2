import {handleShots} from "./shotHandler.js";
import {drawPlot} from "./plot.js";

const form = document.querySelector('.shot-form')
form.addEventListener('submit', async function (event) {
    event.preventDefault()
    const formData = new FormData(form)
    const x = formData.get('x').replace(',', '.')
    const y = formData.get('y').replace(',', '.')
    const r = formData.getAll('r').map(r => r.replace(',', '.'))
    await handleShots(r.map(r => ({x, y, r})))
})

export function configureFields() {
    document.querySelectorAll('input[type="radio"]').forEach((xRadio) => {
        xRadio.addEventListener('change', () => {
            sessionStorage.x = xRadio.value
        })
    })
    if (sessionStorage.x) document.querySelector(`input[type="radio"][value="${sessionStorage.x}"]`).checked = true

    const yField = form.querySelector('input[name="y"]')
    if (sessionStorage.y) yField.value = sessionStorage.y
    yField.addEventListener('change', () => {
        sessionStorage.y = yField.value
    })

    document.querySelectorAll('input[type="checkbox"]').forEach((rCheckbox) => {
        rCheckbox.addEventListener('change', () => {
            let rList = JSON.parse(sessionStorage.r ?? '[]')
            if (rCheckbox.checked) rList.push(rCheckbox.value)
            else rList = rList.filter((val) => val !== rCheckbox.value)
            sessionStorage.r = JSON.stringify(rList)
            drawPlot()
        })
    })
    const rList = JSON.parse(sessionStorage.r ?? '[]')
    rList.forEach((r) => {
        document.querySelector(`input[type="checkbox"][value="${r}"]`).checked = true
    })
}
