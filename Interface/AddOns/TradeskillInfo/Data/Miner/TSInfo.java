import java.net.*;
import java.io.*;
import java.util.*;
import org.json.*;

class Item
{
	public int id;
	public int spell;
	public String skill;
	public String reagents;
	public int recipe;
	public int yield;
	public int itemid;

	public Item()
	{
		id = 0;
		spell = 0;
		skill = "";
		reagents = "";
		recipe = 0;
		yield = 0;
		itemid = 0;
	}

	public String toString() {
		if (skill.length() > 1) {
		String temp = "\t[" + id + "] = \"" + (spell != 0 ? spell + "|" : "") + skill + "|" + reagents;
//		String temp = "\t[" + spell + "] = \"" + id + "|" + skill + "|" + reagents;

		if (itemid != 0) {
			return temp + "|" + (recipe != 0 ? recipe : "") + "|" + (yield != 0 ? yield : "") + "|" + itemid + "\",";
		}
		if (yield != 0) {
			return temp + "|" + (recipe != 0 ? recipe : "") + "|" + yield + "\",";
		}
		if (recipe != 0) {
			return temp + "|" + recipe + "\",";
		}

		return temp + "\",";
		}
		return "";
	}
}


class SpecialCase
{
	public int id;
	public ArrayList list;

	public SpecialCase(int id)
	{
		this.id = id;
		list = new ArrayList();
	}

	public String toString() {
		String temp = "";
		for (Object item : list) {
			temp += item + ",";
		}
		return "\t[" + id + "] = \"" + temp.substring(0, temp.length() - 1) + "\",";
	}
}


class Recipe
{
	public int id;
	public int result;
	public String source;
	public String price;
	public String factionrank;

	public Recipe(int id, int result)
	{
		this.id = id;
		this.result = result;
		source = "V";
		price = "";
		factionrank = "";
	}

	public String toString() {
//		return "\t[" + id + "] = \"" + result + "|" + source + "|" + price + "|" + factionrank + "\",";
		return "\t[" + id + "] = \"" + result + "|" + source + "\",";
	}
}


public class TSInfo
{
	public int maxSpecialCase;
	public ArrayList<SpecialCase> specialcases;
	public ArrayList combines;
	public Map<Integer, String> components;
	public ArrayList recipes;

	public TSInfo()
	{
		maxSpecialCase = 0;
		specialcases = new ArrayList();
		combines = new ArrayList();
		components = new HashMap<Integer, String>();
		recipes = new ArrayList();
	}

	public Item getItem(int id)
	{
		for (Object entry : combines) {
			if (entry instanceof Item) {
				Item item = (Item)entry;
				if (item.id == id || item.itemid == id) {
					return item;
				}
			}
		}
		return null;
	}

	public Item getSpellItem(int spell)
	{
		for (Object entry : combines) {
			if (entry instanceof Item) {
				Item item = (Item)entry;
				if (spell > 0 && item.spell == spell) {
					return item;
				}
				if (spell < 0 && item.id == spell) {
					return item;
				}
			}
		}
		return null;
	}

	public SpecialCase getSpecialCase(int id)
	{
		for (SpecialCase entry : specialcases) {
			if (entry.id == id) {
				return entry;
			}
		}
		SpecialCase entry = new SpecialCase(id);
		specialcases.add(entry);
		return entry;
	}

	public void addCombine(Item newItem)
	{
		int id = newItem.id;
		Item oldItem = getItem(id);
		if (oldItem == null) {
			combines.add(newItem);
			return;
		}

		SpecialCase sc = getSpecialCase(id);

		if (oldItem.itemid == 0) {
			maxSpecialCase += 1;
			oldItem.itemid = id;
			oldItem.id = maxSpecialCase;
			sc.list.add(maxSpecialCase);
		}

		maxSpecialCase += 1;
		newItem.itemid = id;
		newItem.id = maxSpecialCase;
		sc.list.add(maxSpecialCase);

		combines.add(newItem);
	}

	public int getId(JSONObject obj) throws JSONException
	{
		return obj != null ? obj.getInt("id") : 0;
	}

	public int getProfessionId(String profession)
	{
		switch (profession) {
			case "Alchemy"        : return 171;
			case "Mining"         : return 186;
//			case "First Aid"      : return 129;
			case "Engineering"    : return 202;
			case "Inscription"    : return 773;
			case "Jewelcrafting"  : return 755;
			case "Cooking"        : return 185;
			case "Leatherworking" : return 165;
			case "Blacksmithing"  : return 164;
			case "Tailoring"      : return 197;
			case "Enchanting"     : return 333;
		}
		return 0;
	}

	public String getSkill(JSONObject obj) throws JSONException
	{
		String temp = "";
		switch (obj.getString("school")) {
			case "Alchemy"        : temp = "A"; break;
			case "Mining"         : temp = "Y"; break;
//			case "First Aid"      : temp = "X"; break;
			case "Engineering"    : temp = "E"; break;
			case "Inscription"    : temp = "I"; break;
			case "Jewelcrafting"  : temp = "J"; break;
			case "Cooking"        : temp = "W"; break;
			case "Leatherworking" : temp = "L"; break;
			case "Blacksmithing"  : temp = "B"; break;
			case "Tailoring"      : temp = "T"; break;
			case "Enchanting"     : temp = "D"; break;
		}
//		int level = obj.optInt("level");
//		temp += level + "/" + level + "/" +level + "/" +level;
		return temp;
	}

	public String getReagents(JSONArray arr) throws JSONException
	{
		String temp = "";
		if (arr != null) {
			for (int i = 0; i < arr.length(); i++) {
				JSONObject obj = arr.getJSONObject(i);
				int id = obj.optInt("id");
				components.put(id, "V");
				temp += id;
				int c = obj.getInt("c");
				if (c > 1) {
					temp += ":" + c;
				}
				temp += " ";
			}
		}
		return temp.trim();
	}

	public int getRecipe(JSONArray arr) throws JSONException
	{
		if (arr != null) {
			JSONObject recipe = arr.optJSONObject(0);
			if (recipe != null) {
				return recipe.optInt("id");
			}
		}
		return 0;
	}

	public void read(String line) throws JSONException
	{
		JSONArray jArray = new JSONArray(line);
		if (jArray.length() > 0) {
			JSONObject jObject = jArray.optJSONObject(0);
			if (jObject != null) {
				JSONArray rows = jObject.optJSONArray("rows");
				if (rows != null) {
					for (int i = 0; i < rows.length(); i++) {
						JSONObject row = rows.getJSONObject(i);
						int id = getId(row.optJSONObject("p"));
						if (id != 0) {
							String reagents = getReagents(row.optJSONArray("re"));
							if (reagents != "") {
								Item item = new Item();
								item.id = id;
								item.reagents = reagents;
								item.spell = row.getInt("id");
								item.skill = getSkill(row);
								item.recipe = getRecipe(row.optJSONArray("rec"));
/*								String school = row.optString("school");
								if (school.equals("Enchanting")) {
									id = -item.spell;
									item.spell = id;
//									item.reagents += " 38682";
									Item fake = new Item();
									fake.id = id;
									fake.skill = item.skill;
									fake.reagents = reagents;
									fake.recipe = item.recipe;
									addCombine(fake);
								}
*/								addCombine(item);
								if (item.recipe > 0) {
									recipes.add(new Recipe(item.recipe, id));
								}
							}
						}
					}
				}
			}
		}
	}

	public void readFromBuffed(String profession)
	{
		String prefix = "var bt = new Btabs(";
		String suffix = ");bt.init();</script>";
		try
		{
			URL url = new URL("http://wowdata.getbuffed.com/spell/profession/" + getProfessionId(profession));
			URLConnection bc = url.openConnection();
			BufferedReader in = new BufferedReader(new InputStreamReader(bc.getInputStream()));

			String line;
			while ((line = in.readLine()) != null) {
				if (line.startsWith(prefix) && line.endsWith(suffix)) {
					combines.add("\n--[[ " + profession + " ]]--");
					recipes.add("\n--[[ " + profession + " ]]--");
					read(line.substring(prefix.length(), line.length() - suffix.length()));
					break;
				}
			}
			in.close();
		}
		catch (Exception e)
		{
			e.printStackTrace();
		}
	}


// Components
// [itemid] = "source"
// Source
// 	V = Vendor(5)
// 	D = Dropped(2)
// 	C = Crafted(1)
// 	M = Mined
// 	H = Herbalism
// 	S = Skinned
// 	F = Fished
// 	E = Disenchanted
// 	G = Gathered(7)
// 	P = Pickpocketed

// 1 Hergestellt
// 2 Drop
// 3 PvP
// 5 Händler
// 6 Lehrer
// 7 Entdeckung
// 10 Startausrüstung
// 12 Erfolg


	public void readFromWowHead(String profession)
	{
		String prefix = "new Listview(";
		String suffix = "});";
		String offset = "data: ";
		try
		{
			URL url = new URL("http://www.wowhead.com/skill=" + getProfessionId(profession));
			URLConnection bc = url.openConnection();
			BufferedReader in = new BufferedReader(new InputStreamReader(bc.getInputStream()));

			String line;
			while ((line = in.readLine()) != null) {
				if (line.startsWith(prefix) && line.endsWith(suffix)) {
					int index = line.indexOf(offset);
					if (index != -1) {
						line = line.substring(index + offset.length(), line.length() - suffix.length());
						JSONArray rows = new JSONArray(line);
						for (int i = 0; i < rows.length(); i++) {
							JSONObject row = rows.getJSONObject(i);
							int id = row.optInt("id");
							Item item = getSpellItem(id);
							if (item != null) {
								JSONArray colors = row.optJSONArray("colors");
								if (colors != null) {
									int orange = colors.getInt(0);
									int yellow = colors.getInt(1);
									int green  = colors.getInt(2);
									int grey   = colors.getInt(3);

									if (green == 0) { green = grey; }
									if (yellow == 0) { yellow = green; }
									if (orange == 0) { orange = yellow; }

									item.skill = item.skill + orange + "/" + yellow + "/" + green + "/" + grey;
									
//									String skill = colors.toString().replace(',', '/');
//									item.skill = item.skill + skill.substring(1, skill.length() - 1);
								}
								JSONArray creates = row.optJSONArray("creates");
								if (creates != null) {
									item.yield = creates.optInt(1);
								}
/*								if (profession.equals("Enchanting")) {
									Item fake = getSpellItem(-id);
									if (fake != null) {
										fake.skill = item.skill;
										fake.yield = item.yield;
									}
								}
*/							}
						}
					}
					break;
				}
			}
			in.close();
		}
		catch (Exception e)
		{
			e.printStackTrace();
		}
	}

	public void writeToFile(String filename)
	{
		try
		{
			BufferedWriter out = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(new File(filename))));

			out.write("\nTradeskillInfo.vars.specialcases = {\n");
			for (Object item : specialcases) {
				out.write(item + "\n");
			}
			out.write("}\n");

			out.write("\nTradeskillInfo.vars.combines = {\n");
			for (Object item : combines) {
				out.write(item + "\n");
			}
			out.write("}\n");

			out.write("\nTradeskillInfo.vars.components = {\n");
			for (Map.Entry<Integer, String> entry : components.entrySet())
			{
				out.write("\t[" + entry.getKey() + "] = \"" + entry.getValue() + "\",\n");
			}
			out.write("}\n");

			out.write("\nTradeskillInfo.vars.recipes = {\n");
			for (Object item : recipes) {
				out.write(item + "\n");
			}
			out.write("}\n");

			out.close();
		}
		catch (Exception e)
		{
			e.printStackTrace();
		}
	}


	public static void main(String argv[])
	{
		long starttime = System.currentTimeMillis();

		System.out.println("Beginning program...");
		TSInfo tsi = new TSInfo();

		String[] professions = {
			"Alchemy",
			"Mining",
//			"First Aid",
			"Engineering",
			"Inscription",
			"Jewelcrafting",
			"Cooking",
			"Leatherworking",
			"Blacksmithing",
			"Tailoring",
			"Enchanting"
		};

		for (String profession : professions) {
			System.out.println("Scanning " + profession + "...");
			tsi.readFromBuffed(profession);
			tsi.readFromWowHead(profession);
		}

		System.out.println("Saving data to Data.lua...");
		tsi.writeToFile("../Data.lua");

		long difftime = System.currentTimeMillis() - starttime;
		System.out.println("Program completed in " + difftime / 1000 + " seconds.");
	}
}
