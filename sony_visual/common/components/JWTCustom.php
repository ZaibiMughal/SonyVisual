<?php
namespace common\components;

use Firebase\JWT\BeforeValidException;
use Firebase\JWT\ExpiredException;
use Firebase\JWT\JWT;
use Firebase\JWT\Key;
use Firebase\JWT\SignatureInvalidException;
use yii\base\Component;
use yii\base\Exception;

class JWTCustom extends Component {

    public String $key;
    public String $algorithm;
    public String $issuer;
    public String $audience;


    /**
     * @throws Exception
     */
    public function generateToken($id){

        $nbf = time();
        $expiryTime = \Yii::$app->params['jwt_exp'];
//        $expiryTime = time();
        $payload = [
            'iss' => $this->issuer,
            'aud' => $this->audience,
            'iat' => time(),
            'nbf' => $nbf,
            'exp' => $expiryTime,
            'id'  => $id
        ];

        try {
            return JWT::encode($payload, $this->key, $this->algorithm ? $this->algorithm : 'HS256');
        } catch (Exception $e){
            throw new Exception('Something went wrong while generating token, try again later!');
        }
    }

    public function verifyToken($token){
        try {
            return JWT::decode($token, new Key($this->key, $this->algorithm ? $this->algorithm : 'HS256'));
        } catch (\InvalidArgumentException $e) {
            throw new Exception('Invalid arguments!');
            // provided key/key-array is empty or malformed.
        } catch (\DomainException $e) {
            throw new Exception('Unable to perform operation right now!');
            // provided algorithm is unsupported OR
            // provided key is invalid OR
            // unknown error thrown in openSSL or libsodium OR
            // libsodium is required but not available.
        } catch (SignatureInvalidException $e) {
            throw new Exception('JWT signature verification failed');
            // provided JWT signature verification failed.
        } catch (BeforeValidException $e) {
            throw new Exception('Token is not usable right now, try again later!');
            // provided JWT is trying to be used before "nbf" claim OR
            // provided JWT is trying to be used before "iat" claim.
        } catch (ExpiredException $e) {
            throw new Exception('Token is expired, generate a new one!');
            // provided JWT is trying to be used after "exp" claim.
        } catch (\UnexpectedValueException $e) {
            throw new Exception('Token is invalid or wrong argument!');
            // provided JWT is malformed OR
            // provided JWT is missing an algorithm / using an unsupported algorithm OR
            // provided JWT algorithm does not match provided key OR
            // provided key ID in key/key-array is empty or invalid.
        }
    }

}


