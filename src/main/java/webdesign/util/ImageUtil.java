package webdesign.util;
import javax.imageio.ImageIO;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.InputStream;

public class ImageUtil {


public void saveAndResizeImage(InputStream input, String destPath) throws Exception {
    // 1. Lire l'image originale
    BufferedImage originalImage = ImageIO.read(input);
    
    // 2. Définir la largeur souhaitée (ex: 1200px)
    int targetWidth = 1200;
    // Calculer la hauteur proportionnelle pour ne pas déformer l'image
    double ratio = (double) originalImage.getHeight() / originalImage.getWidth();
    int targetHeight = (int) (targetWidth * ratio);

    // 3. Créer une nouvelle image vide aux bonnes dimensions
    BufferedImage resizedImage = new BufferedImage(targetWidth, targetHeight, BufferedImage.TYPE_INT_RGB);
    
    // 4. Dessiner l'ancienne image dans la nouvelle
    Graphics2D g = resizedImage.createGraphics();
    // Améliorer la qualité du redimensionnement
    g.setRenderingHint(RenderingHints.KEY_INTERPOLATION, RenderingHints.VALUE_INTERPOLATION_BILINEAR);
    g.drawImage(originalImage, 0, 0, targetWidth, targetHeight, null);
    g.dispose();

    // 5. Sauvegarder sur le disque en JPG (format léger)
    ImageIO.write(resizedImage, "jpg", new File(destPath));
}
}
