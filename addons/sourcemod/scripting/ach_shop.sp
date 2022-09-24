#pragma semicolon 1
#pragma newdecls required

#include <shop>
#include <achievements>

public Plugin myinfo =
{
	name	= "[ACHIEVEMENTS] Shop Reward",
	version	= "0.0.1",
	author	= "Pisex",
    url = "Discord => Pisex#0023"
};

public void OnPluginStart()
{
    if(Achievements_CoreIsLoad())
        Achievements_OnCoreLoaded();
}

public void Achievements_OnCoreLoaded()
{
    Achievements_RegisterTrigger("shop", GetShopReward);
    Achievements_RegisterTrigger("shop_item", GetShopItemReward);
}

void GetShopReward(int iClient, const char[] outcome)
{
    Shop_GiveClientCredits(iClient,StringToInt(outcome));
}

void GetShopItemReward(int iClient, const char[] outcome)
{
    //exp[0] - Идентификатор предмета
    //exp[1] - Категория предмета
    //exp[2] - Количество/срок предмета
    char exp[3][64];
	ExplodeString(outcome, "|", exp, sizeof(exp), sizeof(exp[]));
    
    Shop_GiveClientItem(iClient, Shop_GetItemId(Shop_GetCategoryId(exp[1]),exp[0]), StringToInt(exp[2]));
}