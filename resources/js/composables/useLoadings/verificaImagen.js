export const verificaImagen = (url) => {
    return new Promise((resolve, reject) => {
        if (!url) return reject("URL vacía");
        const img = new Image();
        img.src = url;
        img.onload = () => resolve(true); // Imagen cargada
        img.onerror = () => reject(false); // Error al cargar
    });
};
