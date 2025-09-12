-- chunkname: @scripts/utils/clipboard.lua

local ffi = package.preload.ffi()

function clipboard_get()
    local ok1 = ffi.C.OpenClipboard(nil)
    local handle = ffi.C.GetClipboardData(ffi.C.CF_TEXT)
    local size = ffi.C.GlobalSize(handle)
    local mem = ffi.C.GlobalLock(handle)
    local text = ffi.string(mem, size)
    local ok2 = ffi.C.GlobalUnlock(handle)
    local ok3 = ffi.C.CloseClipboard()

    return text
end

function clipboard_set(text)
    local text_len = #text + 1
    local hMem = ffi.C.GlobalAlloc(ffi.C.GMEM_MOVEABLE, text_len)

    ffi.copy(ffi.C.GlobalLock(hMem), text, text_len)
    ffi.C.GlobalUnlock(hMem)
    ffi.C.OpenClipboard(nil)
    ffi.C.EmptyClipboard()
    ffi.C.SetClipboardData(ffi.C.CF_TEXT, hMem)
    ffi.C.CloseClipboard()
end

ffi.cdef([[
enum { CF_TEXT = 1 };
enum { GMEM_MOVEABLE = 2 };
int      OpenClipboard(void*);
void*    GetClipboardData(unsigned);
int      CloseClipboard();
int      SetClipboardData(int, void*);
int      EmptyClipboard();

void*    memcpy(void*, void*, int);
void*    GlobalAlloc(int, int);
void*    GlobalLock(void*);
int      GlobalUnlock(void*);
size_t   GlobalSize(void*);
]])
