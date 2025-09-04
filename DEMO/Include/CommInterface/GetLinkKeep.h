#ifndef __GET_LINK_KEEP_H__
#define __GET_LINK_KEEP_H__

#include "StdCommMaco.h"
#include "StdInclude.h"
#include "SendFrame.h"
#include "RecvFrame.h"

#include <functional>

struct stLinkKeepSet
{
public:
    CSendFrame KeepFrame;
    CRecvFrame Responesd;

    uint32_t KeepTimeMs;
    bool bImmediatelyEnable;
    CStdCommMaco::LinkKeepType KeepType;
};

#endif  // __GET_LINK_KEEP_H__