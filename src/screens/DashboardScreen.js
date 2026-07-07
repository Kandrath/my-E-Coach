import React, { useState } from 'react';
import { StyleSheet, Text, View, TouchableOpacity } from 'react-native';

export default function DashboardScreen() {
  // États pour stocker les données du jour
  const [calories, setCalories] = useState(0);
  const [water, setWater] = useState(0); // en ml

  const addWater = (amount) => {
    setWater(water + amount);
  };

  return (
    <View style={styles.container}>
      {/* En-tête */}
      <View style={styles.header}>
        <Text style={styles.greeting}>Bonjour, Alexandre ✨</Text>
        <Text style={styles.subtitle}>Prenez soin de vous aujourd'hui.</Text>
      </View>

      {/* Module Calories (Cercle Zen) */}
      <View style={styles.calorieCard}>
        <View style={styles.circle}>
          <Text style={styles.calorieNumber}>{calories}</Text>
          <Text style={styles.calorieLabel}>kcal dépensées</Text>
        </View>
      </View>

      {/* Module Hydratation */}
      <View style={styles.waterCard}>
        <Text style={styles.cardTitle}>Hydratation : {(water / 1000).toFixed(2)}L / 2.5L</Text>
        <View style={styles.waterButtons}>
          <TouchableOpacity style={styles.waterButton} onPress={() => addWater(250)}>
            <Text style={styles.buttonText}>+ 250ml 💧</Text>
          </TouchableOpacity>
          <TouchableOpacity style={styles.waterButton} onPress={() => addWater(500)}>
            <Text style={styles.buttonText}>+ 500ml 💧</Text>
          </TouchableOpacity>
        </View>
      </View>

      {/* Bouton Action Principal */}
      <TouchableOpacity style={styles.ctaButton}>
        <Text style={styles.ctaText}>DÉMARRER UNE ACTIVITÉ</Text>
      </TouchableOpacity>
    </View>
  );
}

// Styles respectant le thème Zen & Épuré
const styles = StyleSheet.create({
  container: { flex: 1, backgroundColor: '#FAF9F6', padding: 20, justifyContent: 'space-around' },
  header: { marginTop: 40 },
  greeting: { fontSize: 24, fontWeight: 'bold', color: '#2C3E50' },
  subtitle: { fontSize: 14, color: '#7F8C8D', marginTop: 5 },
  calorieCard: { alignItems: 'center' },
  circle: { width: 180, height: 180, borderRadius: 90, borderWidth: 6, borderColor: '#A2B997', justifyContent: 'center', alignItems: 'center', backgroundColor: '#FFF' },
  calorieNumber: { fontSize: 36, fontWeight: 'bold', color: '#2C3E50' },
  calorieLabel: { fontSize: 14, color: '#7F8C8D' },
  waterCard: { backgroundColor: '#FFF', padding: 20, borderRadius: 15, shadowColor: '#000', shadowOffset: { width: 0, height: 2 }, shadowOpacity: 0.05, shadowRadius: 10 },
  cardTitle: { fontSize: 16, fontWeight: '600', color: '#2C3E50', marginBottom: 15, textAlign: 'center' },
  waterButtons: { flexDirection: 'row', justifyContent: 'space-around' },
  waterButton: { backgroundColor: '#E3F2FD', paddingVertical: 10, paddingHorizontal: 20, borderRadius: 20 },
  buttonText: { color: '#1E88E5', fontWeight: '600' },
  ctaButton: { backgroundColor: '#A2B997', paddingVertical: 16, borderRadius: 30, alignItems: 'center', shadowColor: '#A2B997', shadowOffset: { width: 0, height: 4 }, shadowOpacity: 0.3, shadowRadius: 5 },
  ctaText: { color: '#FFF', fontSize: 16, fontWeight: 'bold', letterSpacing: 1 }
});