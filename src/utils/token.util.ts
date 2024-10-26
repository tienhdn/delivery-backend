import type { User } from '~/interfaces';
import jwt from "jsonwebtoken";
export const generateToken = (user:User) =>{
  return jwt.sign({id:user.id}, process.env.JWT_SECRET_KEY as string,{
    expiresIn: "10 days"
  } )
}

