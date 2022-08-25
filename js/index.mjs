document.addEventListener('copy', (e) => {
    const selection = document.getSelection();
    e.clipboardData.setData(
        'text/plain',
        selection.toString().replace(/\u00ad/g, '')
    );
    e.preventDefault();
});
