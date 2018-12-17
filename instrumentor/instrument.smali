.class public Linstrument;
.super Ljava/lang/Object;
.source "instrument.java"


# static fields
.field private static ids:Ljava/util/HashSet;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/HashSet",
            "<",
            "Ljava/lang/Integer;",
            ">;"
        }
    .end annotation
.end field

.field static r:Ljava/util/Random;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 15
    new-instance v0, Ljava/util/HashSet;

    invoke-direct {v0}, Ljava/util/HashSet;-><init>()V

    sput-object v0, Linstrument;->ids:Ljava/util/HashSet;

    .line 16
    new-instance v0, Ljava/util/Random;

    invoke-direct {v0}, Ljava/util/Random;-><init>()V

    sput-object v0, Linstrument;->r:Ljava/util/Random;

    return-void
.end method

.method public constructor <init>()V
    .locals 1

    .prologue
    .line 18
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 19
    new-instance v0, Ljava/util/HashSet;

    invoke-direct {v0}, Ljava/util/HashSet;-><init>()V

    sput-object v0, Linstrument;->ids:Ljava/util/HashSet;

    .line 20
    new-instance v0, Ljava/util/Random;

    invoke-direct {v0}, Ljava/util/Random;-><init>()V

    sput-object v0, Linstrument;->r:Ljava/util/Random;

    .line 21
    return-void
.end method

.method private static getCurLoc()I
    .locals 4

    .prologue
    .line 26
    const/4 v1, 0x0

    .line 28
    .local v1, "tries":I
    :cond_0
    sget-object v2, Linstrument;->r:Ljava/util/Random;

    const/high16 v3, 0x10000

    invoke-virtual {v2, v3}, Ljava/util/Random;->nextInt(I)I

    move-result v0

    .line 29
    .local v0, "id":I
    add-int/lit8 v1, v1, 0x1

    .line 30
    const/16 v2, 0xa

    if-gt v1, v2, :cond_1

    sget-object v2, Linstrument;->ids:Ljava/util/HashSet;

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/util/HashSet;->contains(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_0

    .line 31
    :cond_1
    sget-object v2, Linstrument;->ids:Ljava/util/HashSet;

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/util/HashSet;->add(Ljava/lang/Object;)Z

    .line 32
    return v0
.end method

.method public static instrumentation()V
    .locals 4

    .prologue
    .line 44
    invoke-static {}, Linstrument;->getCurLoc()I

    move-result v0

    .line 46
    .local v0, "id":I
    sget v2, LMem;->prev_loc:I

    xor-int v1, v0, v2

    .line 48
    .local v1, "index":I
    sget-object v2, LMem;->mem:[B

    aget-byte v3, v2, v1

    add-int/lit8 v3, v3, 0x1

    int-to-byte v3, v3

    aput-byte v3, v2, v1

    .line 50
    shr-int/lit8 v2, v0, 0x1

    sput v2, LMem;->prev_loc:I

    .line 53
    invoke-static {}, LMem;->print()V

    .line 54
    return-void
.end method

.method public static test()V
    .locals 2

    .prologue
    .line 36
    const-string v0, "DOSI"

    invoke-static {}, Linstrument;->getCurLoc()I

    move-result v1

    invoke-static {v1}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    .line 40
    return-void
.end method
