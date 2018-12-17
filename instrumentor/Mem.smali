.class public LMem;
.super Ljava/lang/Object;
.source "Mem.java"


# static fields
.field public static final SIZE:I = 0x10000

.field public static mem:[B

.field public static prev_loc:I


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 10
    const/high16 v0, 0x10000

    new-array v0, v0, [B

    sput-object v0, LMem;->mem:[B

    .line 11
    const/4 v0, 0x0

    sput v0, LMem;->prev_loc:I

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .prologue
    .line 7
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static clear()V
    .locals 3

    .prologue
    .line 15
    const/4 v0, 0x0

    .local v0, "i":I
    :goto_0
    const/high16 v1, 0x10000

    if-ge v0, v1, :cond_0

    .line 16
    sget-object v1, LMem;->mem:[B

    const/4 v2, 0x0

    aput-byte v2, v1, v0

    .line 15
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 17
    :cond_0
    return-void
.end method

.method public static print()V
    .locals 4

    .prologue
    .line 20
    const/4 v0, 0x0

    .local v0, "i":I
    :goto_0
    const/high16 v1, 0x10000

    if-ge v0, v1, :cond_1

    .line 21
    sget-object v1, LMem;->mem:[B

    aget-byte v1, v1, v0

    if-eqz v1, :cond_0

    .line 23
    const-string v1, "DOSI"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-static {v0}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "->"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    sget-object v3, LMem;->mem:[B

    aget-byte v3, v3, v0

    invoke-static {v3}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    .line 20
    :cond_0
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 26
    :cond_1
    return-void
.end method
