/*
 * Copyright 2021-2025, SWRTdev
 * Copyright 2021-2025, paldier <paldier@hotmail.com>.
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

	switch(model){
		case SWRT_MODEL_R6300V2:
		case SWRT_MODEL_R6800:
		case SWRT_MODEL_R7000P:
		case SWRT_MODEL_R8500:
		case SWRT_MODEL_R8000P:
		case SWRT_MODEL_RAX70:
		case SWRT_MODEL_RAX80:
		case SWRT_MODEL_RAX120:
		case SWRT_MODEL_RAX200:
		case SWRT_MODEL_MR60:
		case SWRT_MODEL_MS60:
			return "Netgear";
		case SWRT_MODEL_RMAC2100:
		case SWRT_MODEL_RMAX6000:
		case SWRT_MODEL_XMCR660X:
			return "Xiaomi";
		case SWRT_MODEL_K3:
		case SWRT_MODEL_K3C:
			return "Phicomm";
		case SWRT_MODEL_DIR868L:
			return "Dlink";
		case SWRT_MODEL_SBRAC1900P:
		case SWRT_MODEL_SBRAC3200P:
			return "Arris";
		case SWRT_MODEL_EA6700:
			return "Linksys";
		case SWRT_MODEL_TY6202:
		case SWRT_MODEL_TY6201_RTK:
		case SWRT_MODEL_TY6201_BCM:
		case SWRT_MODEL_TYAX5400:
		case SWRT_MODEL_TY6201PRO:
			return "Tianyi";
		case SWRT_MODEL_RGMA2820A:
		case SWRT_MODEL_RGMA2820B:
		case SWRT_MODEL_RGMA3062:
			return "Ruijie";
		case SWRT_MODEL_JCGQ10PRO:
		case SWRT_MODEL_JCGQ20:
			return "JCG";
		case SWRT_MODEL_H3CTX1801:
			return "H3C";
		case SWRT_MODEL_360V6:
		case SWRT_MODEL_360T7:
			return "360";
		case SWRT_MODEL_JDCAX1800:
		case SWRT_MODEL_JDCAX3000:
		case SWRT_MODEL_JDCBE6500:
			return "JDCloud";
		default:
			return "Unknown";
	}
}

static int get_arch(void)
{
	char buf[256];
	struct utsname uts;
	
	if(uname(&uts) == 0){
		if(!strcmp(uts.machine, "armv7l")){
			if(get_socvendors() == SOC_BCM470X)
				snprintf(buf, sizeof(buf), "dbus set softcenter_arch=%s", "arm");
			else
				snprintf(buf, sizeof(buf), "dbus set softcenter_arch=%s", "armng");
		}else if(!strcmp(uts.machine, "mips")){
			if(get_socvendors() == SOC_MTK)
				snprintf(buf, sizeof(buf), "dbus set softcenter_arch=%s", "mipsle");
			else
				snprintf(buf, sizeof(buf), "dbus set softcenter_arch=%s", "mips");
		}else if(!strcmp(uts.machine, "aarch64")){
			snprintf(buf, sizeof(buf), "dbus set softcenter_arch=%s", "arm64");
		}else
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
	int modelid = MODEL_UNKNOWN;
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
			modelid = get_modelname(modelname);
			if(modelid != MODEL_UNKNOWN && is_swrt(modelname))
				printf("This is %s router, model:%s\n", print_vendors(modelname), get_modelnameid(modelid));
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
			if(tcode[0])
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
				printf("This device is not supported. see https://blog.paldier.com/categories/firmware/\n");
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


