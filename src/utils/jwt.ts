import { SignJWT, jwtVerify } from 'jose';

/**
 * Generate a JWT token
 * @param payload - The data to encode in the token
 * @param secret - The secret key for signing
 * @param expiresIn - Token expiration time (default: 7 days)
 */
export async function generateToken(
    payload: Record<string, any>,
    secret: string,
    expiresIn: string = '7d'
): Promise<string> {
    const encoder = new TextEncoder();
    const secretKey = encoder.encode(secret);

    const token = await new SignJWT(payload)
        .setProtectedHeader({ alg: 'HS256' })
        .setIssuedAt()
        .setExpirationTime(expiresIn)
        .sign(secretKey);

    return token;
}

/**
 * Verify and decode a JWT token
 * @param token - The JWT token to verify
 * @param secret - The secret key for verification
 */
export async function verifyToken(token: string, secret: string) {
    try {
        const encoder = new TextEncoder();
        const secretKey = encoder.encode(secret);

        const { payload } = await jwtVerify(token, secretKey);
        return { valid: true, payload };
    } catch (error) {
        return { valid: false, payload: null, error };
    }
}
