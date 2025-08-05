/datum/book_entry/farming_basics
	name = "Farming Fundamentals"
	category = "Agriculture"

/datum/book_entry/farming_basics/inner_book_html(mob/user)
	return {"
		<div style="text-align: left;">
			<h2>Introduction to Agriculture</h2>
			Farming is the foundation of civilization, providing sustenance through the cultivation of crops. This guide covers the essential principles of plant cultivation, soil management, and crop optimization.<br>
			<br>

			<h2>Basic Plant Growth</h2>
			All plants follow a basic growth cycle:<br>
			<b>Seeding:</b> Plant seeds in prepared soil<br>
			<b>Maturation:</b> Plants grow over time, consuming nutrients and water<br>
			<b>Production:</b> Mature plants develop harvestable produce<br>
			<b>Harvest:</b> Collect the produce - annual plants die after harvest, perennials continue producing<br>
			<br>

			<h2>Soil Nutrients</h2>
			Plants require three primary nutrients from soil, each with maximum levels of 200 units:<br>
			<b>Nitrogen (N):</b> Essential for leaf growth and overall plant vigor during maturation. Heavy feeders like grains consume large amounts.<br>
			<b>Phosphorus (P):</b> Critical for root development, flowering, and fruit production. More important during the production phase.<br>
			<b>Potassium (K):</b> Improves disease resistance, cold tolerance, and overall plant health throughout growth.<br>
			<br>

			<h2>Water Management</h2>
			Soil can hold up to 150 units of water. Different plants have varying water consumption rates. Monitor soil moisture and water regularly - plants will suffer health damage without adequate water. Rain provides natural irrigation.<br>
			<br>

			<h2>Plant Types</h2>
			<b>Annual Plants:</b> Complete their life cycle in one season. Die after harvest and must be replanted.<br>
			<b>Perennial Plants:</b> Continue producing over multiple harvests. More efficient long-term but require ongoing care.<br>
			<br>

			<h2>Getting Started</h2>
			Begin with hardy, low-maintenance crops like herbs or root vegetables. These typically have lower nutrient requirements and are more forgiving to new farmers while you learn soil and water management. Always prepare soil properly by tilling before planting.
		</div>
	"}
