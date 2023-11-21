export function showError(message) {
    Toastify({
        text: message,
        duration: 4000,
        style: {
            background: "white",
            color: "red",
        },
    }).showToast();
}
