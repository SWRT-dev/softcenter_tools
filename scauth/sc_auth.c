/*
 * Copyright 2021-2023, SWRTdev
 * Copyright 2021-2023, paldier <paldier@hotmail.com>.
 * All Rights Reserved.
 */

//$CC -static $CFLAGS $LDFLAGS sc_auth.c -o sc_auth
//${CORSS_PREFIX}strip sc_auth
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/utsname.h>
#include "sc_auth.h"

//#define SC_AUTH_DEBUG

static const struct vendors_s netgear_list[] = {
	{ SWRT_MODEL_R6300V2 		},
	{ SWRT_MODEL_R6800			},
	{ SWRT_MODEL_R7000P 		},
	{ SWRT_MODEL_R8500 			},
	{ SWRT_MODEL_R8000P 		},
	{ SWRT_MODEL_RAX70 			},
	{ SWRT_MODEL_RAX120 		},
	{ SWRT_MODEL_MR60 			},
	{ SWRT_MODEL_MS60 			},
	{ SWRT_MODEL_RAX200 		},
	{ SWRT_MODEL_SWRTMIN 		},
};

static const struct vendors_s xiaomi_list[] = {
	{ SWRT_MODEL_RMAC2100 		},
	{ SWRT_MODEL_RMAX6000 		},
	{ SWRT_MODEL_SWRTMIN 		},
};

static const struct vendors_s phicomm_list[] = {
	{ SWRT_MODEL_K3 			},
	{ SWRT_MODEL_K3C 			},
	{ SWRT_MODEL_SWRTMIN 		},
};

static const struct vendors_s dlink_list[] = {
	{ SWRT_MODEL_DIR868L 		},
	{ SWRT_MODEL_SWRTMIN 		},
};

static const struct vendors_s arris_list[] = {
	{ SWRT_MODEL_SBRAC1900P 	},
	{ SWRT_MODEL_SBRAC3200P 	},
	{ SWRT_MODEL_SWRTMIN 		},
};

static const struct vendors_s linksys_list[] = {
	{ SWRT_MODEL_EA6700 		},
	{ SWRT_MODEL_SWRTMIN 		},
};

static const struct vendors_s tianyi_list[] = {
	{ SWRT_MODEL_TY6202 		},
	{ SWRT_MODEL_TY6201_RTK 	},
	{ SWRT_MODEL_TY6201_BCM 	},
	{ SWRT_MODEL_TYAX5400 		},
	{ SWRT_MODEL_TY6201PRO 		},
	{ SWRT_MODEL_SWRTMIN 		},
};

static const struct vendors_s jcg_list[] = {
	{ SWRT_MODEL_JCGQ10PRO 		},
	{ SWRT_MODEL_SWRTMIN 		},
};

static const struct vendors_s h3c_list[] = {
	{ SWRT_MODEL_H3CTX1801 		},
	{ SWRT_MODEL_SWRTMIN 		},
};

static const struct vendors_s rg_list[] = {
	{ SWRT_MODEL_RGMA2820A 		},
	{ SWRT_MODEL_RGMA2820B 		},
	{ SWRT_MODEL_RGMA3032 		},
	{ SWRT_MODEL_SWRTMIN 		},
};

static int show_help(void)
{
	printf("usage:\n");
	printf("sc_auth firmware\n");
	printf("\tshow firmware\n");
	printf("sc_auth tcode\n");
	printf("\tset softcenter server\n");
	printf("sc_auth model\n");
	printf("\tshow model\n");
	printf("sc_auth arch\n");
	printf("\tset softcenter arch\n");
	return 0;
}

static char *print_vendors(char *pid)
{
	int model = get_modelname(pid);
	const struct vendors_s *p;

	for (p = &netgear_list[0]; p->model; ++p) {
		if (model == p->model)
			return "Netgear";
	}
	for (p = &xiaomi_list[0]; p->model; ++p) {
		if (model == p->model)
			return "Xiaomi";
	}
	for (p = &phicomm_list[0]; p->model; ++p) {
		if (model == p->model)
			return "Phicomm";
	}
	for (p = &dlink_list[0]; p->model; ++p) {
		if (model == p->model)
			return "Dlink";
	}
	for (p = &arris_list[0]; p->model; ++p) {
		if (model == p->model)
			return "Arris";
	}
	for (p = &linksys_list[0]; p->model; ++p) {
		if (model == p->model)
			return "Linksys";
	}
	for (p = &tianyi_list[0]; p->model; ++p) {
		if (model == p->model)
			return "Tianyi";
	}
	for (p = &rg_list[0]; p->model; ++p) {
		if (model == p->model)
			return "Ruijie";
	}
	for (p = &jcg_list[0]; p->model; ++p) {
		if (model == p->model)
			return "JCG";
	}

	for (p = &h3c_list[0]; p->model; ++p) {
		if (model == p->model)
			return "H3C";
	}
	return "Unknown";
}

static int get_arch(void)
{
	char buf[256];
	struct utsname uts;
	
	if(uname(&uts) == 0){
		if(!strcmp(uts.machine, "armv7l")){
			if(get_socvendors() == SOC_BCM470X)
				snprintf(buf, sizeof(buf), "dbus set softcenter_arch=armv7l");
			else
				snprintf(buf, sizeof(buf), "dbus set softcenter_arch=armng");
		} else if(!strcmp(uts.machine, "mips")){
			if(get_socvendors() == SOC_MTK)
				snprintf(buf, sizeof(buf), "dbus set softcenter_arch=mipsle");
			else
				snprintf(buf, sizeof(buf), "dbus set softcenter_arch=mips");
		} else
			snprintf(buf, sizeof(buf), "dbus set softcenter_arch=%s", uts.machine);
#if defined(SC_AUTH_DEBUG)
		printf("%s\n", buf);
#else
		system(buf);
#endif
	}else{
		printf("get kernel version fail\n");
	}
	return 0;
}

int main(int argc, char **argv)
{
	FILE *fp;
	char buf[50];
	char modelname[16];
	char cmd[40];
	char tcode[6];
	memset(tcode, 0, sizeof(tcode));
	memset(buf, 0, sizeof(buf));
	memset(cmd, 0, sizeof(cmd));
	memset(modelname, 0, sizeof(modelname));
#if defined(SC_AUTH_DEBUG)
	printf("DEBUG MODE\n");
#endif
	if (argc != 2) {
		show_help();
	} else {
		if (!strcmp(argv[1], "firmware")) {
			snprintf(modelname, sizeof(modelname), "%s", nvram_get("modelname"));
			snprintf(cmd, sizeof(cmd), "%s", nvram_get("productid"));
			if(is_swrt(modelname))
				printf("This is %s router, model:%s\n", print_vendors(modelname), modelname);
			else if(is_asuswrt(cmd))
				printf("This is ASUS router, model:%s\n", cmd);
			else
				printf("This is an unknown device, model:%s\n", cmd);
			snprintf(buf, sizeof(buf), "%s", nvram_get("buildinfo"));
			if((strstr(buf, "MerlinRdev") || strstr(buf, "SWRTdev")) && (strstr(buf, "paldier") || strstr(buf, "iss"))){
				printf("This firmware was built by SWRT Development Team\n");
				return 0;
			}
			printf("This firmware was built by anonymous person\n");
		} else if (!strcmp(argv[1], "tcode")) {
			snprintf(buf, sizeof(buf), "%s", nvram_get("productid"));
			snprintf(modelname, sizeof(modelname), "%s", nvram_get("modelname"));
			snprintf(tcode, sizeof(tcode), "%s", nvram_get("territory_code"));
			if(*tcode)
				tcode[2] = 0x0;
			else
				snprintf(tcode, sizeof(tcode), "GB");
			snprintf(cmd, sizeof(cmd), "dbus set softcenter_server_tcode=%s", tcode);
			if(!strlen(buf) || !is_asuswrt(buf)){
#if defined(SC_AUTH_DEBUG)
				printf("dbus set softcenter_server_tcode=GB\n");
#else
				system("dbus set softcenter_server_tcode=GB");
#endif
				printf("This device is not asus or swrt model.\n");
			}else if(is_swrt(modelname)){
				switch (get_modelname(modelname)){
				case SWRT_MODEL_R7000P:
				case SWRT_MODEL_SBRAC1900P:
				case SWRT_MODEL_SBRAC3200P:
				case SWRT_MODEL_R8000P:
				case SWRT_MODEL_K3:
				case SWRT_MODEL_XWR3100:
#if defined(SC_AUTH_DEBUG)
					printf("dbus set softcenter_server_tcode=CN\n");
#else
					system("dbus set softcenter_server_tcode=CN");
#endif
					break;
				default:
#if defined(SC_AUTH_DEBUG)
					printf("%s\n", cmd);
#else
					system(cmd);
#endif
				}
			}else{

#if defined(SC_AUTH_DEBUG)
				printf(cmd);
#else

				system(cmd);
#endif
			}
		} else if (!strcmp(argv[1], "model")) {
			snprintf(buf, sizeof(buf), "%s", nvram_get("productid"));
			snprintf(modelname, sizeof(modelname), "%s", nvram_get("modelname"));
			printf("model=%s, modelname=%s\n", buf, modelname);
		} else if (!strcmp(argv[1], "arch")) {
			get_arch();
		} else {
			show_help();
		}
	}
	return 0;
}


