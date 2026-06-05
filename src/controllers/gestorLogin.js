const db = require('../models/db');
const crypto = require('crypto');
const axios = require('axios');

const gestorLogin = {
    mostrarLogin: (req, res) => {
        res.render('login', {
            usuario: req.session.usuario
        });
    },

    validarUsuario: async (req, res) => {
        const { user, pass, ['g-recaptcha-response']: recaptchaToken } = req.body;

        // --- VALIDACIÓN DE CAPTCHA ---
        if (!recaptchaToken) {
            return res.send('Por favor, completa el reCAPTCHA.');
        }

        try {
            // Verificar con Google
            const secretKey = process.env.RECAPTCHA_SECRET_KEY;
            const verifyUrl = `https://www.google.com/recaptcha/api/siteverify?secret=${secretKey}&response=${recaptchaToken}`;
            
            const response = await axios.post(verifyUrl);
            if (!response.data.success) {
                return res.send('Error en la verificación del reCAPTCHA. Inténtalo de nuevo.');
            }
            // -----------------------------
            const [rows] = await db.query('SELECT * FROM usuarios WHERE Usuario = ?', [user]);
            if (rows.length === 0) return res.send('Usuario no encontrado');
            
            const usuarioDB = rows[0];
            const algoritmo = usuarioDB.Password.length === 64 ? 'sha256' : 'sha1';
            const hashIngresado = crypto.createHash(algoritmo).update(pass).digest('hex');
            
            if (hashIngresado === usuarioDB.Password) {
                req.session.usuario = usuarioDB;

                console.log("Redireccionando según perfil:", usuarioDB.Perfil);

                switch (usuarioDB.Perfil) {
                    case 'administrador': return res.redirect('/administrador');
                    case 'dueno': return res.redirect('/dueno');
                    case 'vendedor': return res.redirect('/vendedor');
                    default: return res.send('Perfil no reconocido');
                }
            } else {
                return res.send('Contraseña incorrecta');
            }
        } catch (error) {
            console.error(error);
            res.status(500).send('Error en el sistema');
        }
    },

    cerrarSesion: (req, res) => {
        req.session.destroy((err) => {
            if (err) {
                console.error("Error al destruir sesión:", err);
                return res.redirect('/' + (req.session.usuario ? req.session.usuario.Perfil : ''));
            }
            res.clearCookie('connect.sid');
            res.redirect('/');
        });
    }
};

module.exports = gestorLogin;