/*
 * Copyright 2021, SWRT
 * Copyright 2021, paldier <paldier@hotmail.com>.
 * All Rights Reserved.
 */

#ifndef _sc_auth_h_
#define _sc_auth_h_

struct model_s {
	char *pid;
	int model;
};

enum {
	MODEL_SWRTMIN = 0,
	MODEL_K3,
	MODEL_XWR3100,
	MODEL_R7000P,
	MODEL_EA6700,
	MODEL_SBRAC1900P,
	MODEL_F9K1118,
	MODEL_SBRAC3200P,
	MODEL_R8500,
	MODEL_R8000P,
	MODEL_K3C,
	MODEL_TY6201_RTK,
	MODEL_TY6201_BCM,
	MODEL_RAX120,
	MODEL_DIR868L,
	MODEL_R6300V2,
	//MODEL_RMAC2100,move to model_list
	MODEL_SWRTMAX
};

enum {
	MODEL_GENERIC = -1,
	MODEL_UNKNOWN = 0,
	MODEL_DSLN55U,
	MODEL_DSLAC68U,
	MODEL_EAN66,
	MODEL_RTN11P,
	MODEL_RTN300,
	MODEL_RTN13U,
	MODEL_RTN14U,
	MODEL_RTAC52U,
	MODEL_RTAC51U,
	MODEL_RTN54U,
	MODEL_RTAC54U,
	MODEL_RTN56UB1,
	MODEL_RTN56UB2,
	MODEL_RTAC1200HP,
	MODEL_RTAC55U,
	MODEL_RTAC55UHP,
	MODEL_RT4GAC55U,
	MODEL_RTAC59U,
	MODEL_PLN12,
	MODEL_PLAC56,
	MODEL_PLAC66U,
	MODEL_RTAC58U,
	MODEL_RT4GAC53U,
	MODEL_RTAC82U,
	MODEL_MAPAC1300,
	MODEL_MAPAC2200,
	MODEL_VZWAC1300,
	MODEL_MAPAC1750,
	MODEL_RTAC95U,
	MODEL_MAPAC2200V,
	MODEL_RTN36U3,
	MODEL_RTN56U,
	MODEL_RTN65U,
	MODEL_RTN67U,
	MODEL_RTN12,
	MODEL_RTN12B1,
	MODEL_RTN12C1,
	MODEL_RTN12D1,
	MODEL_RTN12VP,
	MODEL_RTN12HP,
	MODEL_RTN12HP_B1,
	MODEL_APN12,
	MODEL_APN12HP,
	MODEL_RTN16,
	MODEL_RTN18U,
	MODEL_RTN15U,
	MODEL_RTN53,
	MODEL_RTN66U,
	MODEL_RTAC66U,
	MODEL_RTAC68U,
	MODEL_RTAC87U,
	MODEL_RTAC56S,
	MODEL_RTAC56U,
	MODEL_RTAC53U,
	MODEL_RTAC3200,
	MODEL_RTAC88U,
	MODEL_RTAC3100,
	MODEL_RTAC5300,
	MODEL_GTAC5300,
	MODEL_RTN14UHP,
	MODEL_RTN10U,
	MODEL_RTN10P,
	MODEL_RTN10D1,
	MODEL_RTN10PV2,
	MODEL_RTAC1200,
	MODEL_RTAC1200G,
	MODEL_RTAC1200GP,
	MODEL_RTAC1200GA1,
	MODEL_RTAC1200GU,
	MODEL_RPAC66,
	MODEL_RPAC51,
	MODEL_RTAC51UP,
	MODEL_RTAC53,
	MODEL_RTN11P_B1,
	MODEL_RPAC87,
	MODEL_RTAC85U,
	MODEL_RTAC85P,
	MODEL_RTACRH26,
	MODEL_RTN800HP,
	MODEL_RTAC88N,
	MODEL_BRTAC828,
	MODEL_RTAC88S,
	MODEL_RPAC53,
	MODEL_RPAC68U,
	MODEL_RPAC55,
	MODEL_RTAC86U,
	MODEL_GTAC9600,
	MODEL_BLUECAVE,
	MODEL_RTAD7200,
	MODEL_GTAXY16000,
	MODEL_GTAX6000N,
	MODEL_RTAX89U,
	MODEL_RTAC1200V2,
	MODEL_RTN19,
	MODEL_TUFAC1750,
	MODEL_RTAX88U,
	MODEL_GTAX11000,
	MODEL_RTAX92U,
	MODEL_RTAX95Q,
	MODEL_RTAXE95Q,
	MODEL_RTAX56_XD4,
	MODEL_RTAX58U,
	MODEL_RTAX56U,
	MODEL_RPAX56,
	MODEL_SHAC1300,
	MODEL_RPAC92,
	MODEL_RTAC59CD6R,
	MODEL_RTAC59CD6N,
	MODEL_RTAX86U,
	MODEL_RTAX68U,
	MODEL_RT4GAC56,
	MODEL_DSLAX82U,
	MODEL_RTAX55,
	MODEL_GTAXE11000,
	MODEL_RTACRH18,
	MODEL_PLAX56XP4,
	MODEL_CTAX56_XD4,
	MODEL_RTAC68U_V4,
	MODEL_ETAXE96ET10,
	MODEL_ET10,
	MODEL_RMAC2100,
	MODEL_MAX
};

static const struct model_s modelname_list[] = {
	{ "K3", MODEL_K3 },
	{ "XWR3100", MODEL_XWR3100 },
	{ "R7000P", MODEL_R7000P },
	{ "EA6700", MODEL_EA6700 },
	{ "SBRAC1900P", MODEL_SBRAC1900P },
	{ "F9K1118", MODEL_F9K1118 },
	{ "SBRAC3200P", MODEL_SBRAC3200P },
	{ "R8500", MODEL_R8500 },
	{ "R8000P", MODEL_R8000P },
	{ "K3C", MODEL_K3C },
	{ "TY6201_RTK", MODEL_TY6201_RTK },
	{ "TY6201_BCM", MODEL_TY6201_BCM },
	{ "RAX120", MODEL_RAX120 },
	{ "DIR868L", MODEL_DIR868L },
	{ "R6300V2", MODEL_R6300V2 },
	//{ "RMAC2100", MODEL_RMAC2100 },move to model_list
	{ NULL, 0 },
};

static const struct model_s model_list[] = {
	{ "RP-AC68U",		MODEL_RPAC68U		},
	{ "RP-AC53",		MODEL_RPAC53		},
	{ "RP-AC55",		MODEL_RPAC55		},
	{ "RP-AC92",		MODEL_RPAC92		},
	{ "DSL-N55U",		MODEL_DSLN55U		},
	{ "DSL-N55U-B",		MODEL_DSLN55U		},
	{ "EA-N66",			MODEL_EAN66			},
	{ "RT-N11P",		MODEL_RTN11P		},
	{ "RT-N300",		MODEL_RTN300		},
	{ "RT-N13U",		MODEL_RTN13U		},
	{ "RT-N14U",		MODEL_RTN14U		},
	{ "RT-AC52U",		MODEL_RTAC52U		},
	{ "RT-AC51U",		MODEL_RTAC51U		},
	{ "RT-N54U",		MODEL_RTN54U		},
	{ "RT-AC54U",		MODEL_RTAC54U		},
	{ "RT-N56UB1",		MODEL_RTN56UB1		},
	{ "RT-N56UB2",		MODEL_RTN56UB2		},
	{ "RT-N36U3",		MODEL_RTN36U3		},
	{ "RT-N56U",		MODEL_RTN56U		},
	{ "RT-N65U",		MODEL_RTN65U		},
	{ "RT-N67U",		MODEL_RTN67U		},
	{ "RT-AC1200HP",	MODEL_RTAC1200HP	},
	{ "RT-AC1200",		MODEL_RTAC1200		},
	{ "RT-AC1200_V2",	MODEL_RTAC1200V2	},
	{ "RT-ACRH18",      MODEL_RTACRH18      },
	{ "RT-N600",		MODEL_RTAC1200		},
	{ "RT-AC1200GA1",	MODEL_RTAC1200GA1	},
	{ "RT-AC1200GU",	MODEL_RTAC1200GU	},
	{ "RT-AC51U+",		MODEL_RTAC51UP		},
	{ "RT-AC53",		MODEL_RTAC53		},
	{ "RT-N11P_B1",		MODEL_RTN11P_B1		},
	{ "RT-N10P_V3",		MODEL_RTN11P_B1		},
	{ "RP-AC87",		MODEL_RPAC87		},
	{ "RT-AC85U",		MODEL_RTAC85U		},
	{ "RT-AC85P",		MODEL_RTAC85P		},
	{ "RM-AC2100",		MODEL_RTAC85P		},
	{ "RT-ACRH26",		MODEL_RTACRH26		},
	{ "TUF-AC1750",		MODEL_TUFAC1750		},
	{ "RT-AC65U",		MODEL_RTAC85U		},
	{ "RT-N800HP",		MODEL_RTN800HP		},
	{ "RT-AC55U",		MODEL_RTAC55U		},
	{ "RT-AC55UHP",		MODEL_RTAC55UHP		},
	{ "4G-AC55U",		MODEL_RT4GAC55U		},
	{ "RT-N19",			MODEL_RTN19			},
	{ "RT-AC59U",		MODEL_RTAC59U		},
	{ "RT-AC59U_V2",	MODEL_RTAC59U		},
	{ "PL-N12",			MODEL_PLN12			},
	{ "PL-AC56",		MODEL_PLAC56		},
	{ "PL-AC66U",		MODEL_PLAC66U		},
	{ "PL-AX56_XP4",	MODEL_PLAX56XP4		},
	{ "RP-AC66",		MODEL_RPAC66		},
	{ "RP-AC51",		MODEL_RPAC51		},
	{ "RT-AC58U",		MODEL_RTAC58U		},
	{ "4G-AC53U",		MODEL_RT4GAC53U		},
	{ "RT-AC82U",		MODEL_RTAC82U		},
	{ "MAP-AC1300",		MODEL_MAPAC1300		},
	{ "MAP-AC2200",		MODEL_MAPAC2200		},
	{ "VZW-AC1300",		MODEL_VZWAC1300		},
	{ "SH-AC1300",		MODEL_SHAC1300		},
	{ "MAP-AC1750",		MODEL_MAPAC1750		},
	{ "RT-AC59_CD6R",	MODEL_RTAC59CD6R	},
	{ "RT-AC59_CD6N",	MODEL_RTAC59CD6N	},
	{ "RT-AC95U",		MODEL_RTAC95U		},
	{ "RT-AC88N",		MODEL_RTAC88N		},
	{ "BRT-AC828",		MODEL_BRTAC828		},
	{ "RT-AC88S",		MODEL_RTAC88S		},
	{ "RT-AD7200",		MODEL_RTAD7200		},
	{ "GT-AXY16000",	MODEL_GTAXY16000	},
	{ "GT-AX6000N",		MODEL_GTAX6000N		},
	{ "RT-AX89U",		MODEL_RTAX89U		},
	{ "ET10",			MODEL_ET10			},
	{ "GT-AC9600",		MODEL_GTAC9600		},
	{ "BLUECAVE",		MODEL_BLUECAVE		},
	{ "BLUE_CAVE",		MODEL_BLUECAVE		},
	{ "RT-N66U",		MODEL_RTN66U		},
	{ "RT-AC56S",		MODEL_RTAC56S		},
	{ "RT-AC56U",		MODEL_RTAC56U		},
	{ "RT-AC66U",		MODEL_RTAC66U		},
	{ "4G-AC68U",		MODEL_RTAC68U		},
	{ "RT-AC68U",		MODEL_RTAC68U		},
	{ "RT-AC68A",		MODEL_RTAC68U		},
	{ "RT-AC87U",		MODEL_RTAC87U		},
	{ "RT-AC53U",		MODEL_RTAC53U		},
	{ "RT-AC3200",		MODEL_RTAC3200		},
	{ "RT-AC88U",		MODEL_RTAC88U		},
	{ "RT-AC86U",		MODEL_RTAC86U		},
	{ "GT-AC2900",		MODEL_RTAC86U		},
	{ "RT-AC3100",		MODEL_RTAC3100		},
	{ "RT-AC5300",		MODEL_RTAC5300		},
	{ "GT-AC5300",		MODEL_GTAC5300		},
	{ "GT-AX11000",		MODEL_GTAX11000		},
	{ "RT-AX88U",		MODEL_RTAX88U		},
	{ "RT-AX92U",		MODEL_RTAX92U		},
	{ "RT-AX95Q",		MODEL_RTAX95Q		},
	{ "RT-AXE95Q",		MODEL_RTAXE95Q		},
	{ "RT-AX56_XD4",	MODEL_RTAX56_XD4	},
	{ "CT-AX56_XD4",	MODEL_CTAX56_XD4	},
	{ "RT-AX58U",		MODEL_RTAX58U		},
	{ "TUF-AX3000",		MODEL_RTAX58U		},
	{ "TUF-AX5400",     MODEL_RTAX58U		},
	{ "RT-AX82U",       MODEL_RTAX58U		},
	{ "RT-AX82_XD6",	MODEL_RTAX58U		},
	{ "GS-AX3000",		MODEL_RTAX58U		},
	{ "GS-AX5400",		MODEL_RTAX58U		},
	{ "RT-AX56U",		MODEL_RTAX56U		},
	{ "RP-AX56",       	MODEL_RPAX56        },
	{ "RT-AX55",		MODEL_RTAX55		},
	{ "RT-AX1800",		MODEL_RTAX55		},
	{ "RT-AX86U",		MODEL_RTAX86U		},
	{ "RT-AX5700",		MODEL_RTAX86U		},
	{ "RT-AX68U",		MODEL_RTAX68U		},
	{ "RT-AC68U_V4",	MODEL_RTAC68U_V4	},
	{ "GT-AXE11000",	MODEL_GTAXE11000	},
	{ "DSL-AX82U",		MODEL_DSLAX82U		},
	{ "RT-N53",			MODEL_RTN53			},
	{ "RT-N16",			MODEL_RTN16			},
	{ "RT-N18U",		MODEL_RTN18U		},
	{ "RT-N15U",		MODEL_RTN15U		},
	{ "RT-N12",			MODEL_RTN12			},
	{ "RT-N12B1",		MODEL_RTN12B1		},
	{ "RT-N12C1",		MODEL_RTN12C1		},
	{ "RT-N12D1",		MODEL_RTN12D1		},
	{ "RT-N12VP",		MODEL_RTN12VP		},
	{ "RT-N12HP",		MODEL_RTN12HP		},
	{ "RT-N12HP_B1",	MODEL_RTN12HP_B1	},
	{ "AP-N12",			MODEL_APN12			},
	{ "AP-N12HP",		MODEL_APN12HP		},
	{ "RT-N10U",		MODEL_RTN10U		},
	{ "RT-N14UHP",		MODEL_RTN14UHP		},
	{ "RT-N10+",		MODEL_RTN10P		},
	{ "RT-N10P",		MODEL_RTN10P		},
	{ "RT-N10D1",		MODEL_RTN10D1		},
	{ "RT-N10PV2",		MODEL_RTN10PV2		},
	{ "DSL-AC68U",		MODEL_DSLAC68U		},
	{ "RT-AC1200G",		MODEL_RTAC1200G		},
	{ "RT-AC1200G+",	MODEL_RTAC1200GP	},
	{ "RM-AC2100",		MODEL_RMAC2100		},
	{ NULL, 0 },
};

extern int get_model(char *pid);
extern char *get_modelid(int model);
extern int get_modelname(char *pid);
extern char *get_modelnameid(int model);
extern int is_asuswrt(char *pid);
extern int is_swrt(char *pid);
#endif /* _sc_auth_h_ */