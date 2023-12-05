from fastapi import Request, HTTPException
from fastapi.responses import JSONResponse
from .constants import VALIDATION_ERROR, UNAUTHORIZED, FORBIDDEN, NOT_FOUND, SERVER_ERROR

async def error_handler(request: Request, call_next):
    try:
        response = await call_next(request)
        return response

    except Exception as e:
        return JSONResponse(content={"title": "Internal Server Error", "message": str(e)}, status_code=SERVER_ERROR)