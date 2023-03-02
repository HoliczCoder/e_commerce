const { PrismaClient } = require("@prisma/client");
const prisma = new PrismaClient();



const createProduct = (req, res) => {
    const product = prisma.product.create({
        data:{
            
        }
    })


}