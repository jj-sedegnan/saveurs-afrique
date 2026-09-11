import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../data/categories.dart';
import '../models/recipe.dart';
import '../state/app_state.dart';

/// Écran formulaire : ajout d'une recette avec validation sur au moins
/// 7 champs (nom, pays, catégorie, durée, portions, ingrédients, étapes).
class AddRecipeScreen extends StatefulWidget {
  const AddRecipeScreen({super.key});

  @override
  State<AddRecipeScreen> createState() => _AddRecipeScreenState();
}

class _AddRecipeScreenState extends State<AddRecipeScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _countryController = TextEditingController();
  final _minutesController = TextEditingController(text: '30');
  final _servingsController = TextEditingController(text: '4');
  final _ingredientsController = TextEditingController();
  final _stepsController = TextEditingController();
  final _descriptionController = TextEditingController();

  String _category = Categories.values.first.name;
  Difficulty _difficulty = Difficulty.easy;
  bool _saving = false;

  @override
  void dispose() {
    _nameController.dispose();
    _countryController.dispose();
    _minutesController.dispose();
    _servingsController.dispose();
    _ingredientsController.dispose();
    _stepsController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  String? _required(String? value, String field) {
    if (value == null || value.trim().isEmpty) return '$field est requis';
    return null;
  }

  String? _validateNumber(String? value, String field, int min, int max) {
    final required = _required(value, field);
    if (required != null) return required;
    final n = int.tryParse(value!.trim());
    if (n == null) return '$field doit être un nombre entier';
    if (n < min || n > max) return '$field doit être entre $min et $max';
    return null;
  }

  String? _validateLines(String? value, String field, int minCount) {
    final lines =
        value
            ?.split('\n')
            .map((l) => l.trim())
            .where((l) => l.isNotEmpty)
            .toList() ??
        [];
    if (lines.isEmpty) return '$field est requis';
    if (lines.length < minCount) {
      return 'Au moins $minCount ${field.toLowerCase()} (un par ligne)';
    }
    return null;
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Corrigez les champs signalés en rouge.')),
      );
      return;
    }

    setState(() => _saving = true);

    final ingredients = _ingredientsController.text
        .split('\n')
        .map((l) => l.trim())
        .where((l) => l.isNotEmpty)
        .toList();
    final steps = _stepsController.text
        .split('\n')
        .map((l) => l.trim())
        .where((l) => l.isNotEmpty)
        .toList();

    final recipe = context.recipeStore.addRecipe(
      name: _nameController.text,
      country: _countryController.text,
      category: _category,
      description: _descriptionController.text,
      minutes: int.parse(_minutesController.text),
      servings: int.parse(_servingsController.text),
      difficulty: _difficulty,
      ingredients: ingredients,
      steps: steps,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Recette « ${recipe.name} » enregistrée !')),
    );
    context.pop(recipe);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ajouter une recette')),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 760),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
              children: [
                Text(
                  'Partagez un plat de votre région',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _nameController,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: const InputDecoration(
                    labelText: 'Nom du plat *',
                    hintText: 'Ex. : Mafé au poulet',
                    prefixIcon: Icon(Icons.restaurant),
                  ),
                  textInputAction: TextInputAction.next,
                  validator: (v) {
                    final required = _required(v, 'Le nom');
                    if (required != null) return required;
                    if (v!.trim().length < 2) {
                      return 'Le nom doit contenir au moins 2 caractères';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 14),
                TextFormField(
                  controller: _countryController,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: const InputDecoration(
                    labelText: 'Pays / région d\u2019origine *',
                    hintText: 'Ex. : Bénin',
                    prefixIcon: Icon(Icons.public),
                  ),
                  textInputAction: TextInputAction.next,
                  validator: (v) => _required(v, 'Le pays'),
                ),
                const SizedBox(height: 14),
                DropdownButtonFormField<String>(
                  initialValue: _category,
                  decoration: const InputDecoration(
                    labelText: 'Catégorie *',
                    prefixIcon: Icon(Icons.category),
                  ),
                  items: [
                    for (final c in Categories.values)
                      DropdownMenuItem(value: c.name, child: Text(c.name)),
                  ],
                  onChanged: (v) => setState(() => _category = v!),
                  validator: (v) =>
                      v == null ? 'Choisissez une catégorie' : null,
                ),
                const SizedBox(height: 14),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _minutesController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Durée (min) *',
                          prefixIcon: Icon(Icons.schedule),
                        ),
                        validator: (v) =>
                            _validateNumber(v, 'La durée', 1, 1440),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextFormField(
                        controller: _servingsController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Portions *',
                          prefixIcon: Icon(Icons.group),
                        ),
                        validator: (v) =>
                            _validateNumber(v, 'Le nombre de portions', 1, 50),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                DropdownButtonFormField<Difficulty>(
                  initialValue: _difficulty,
                  decoration: const InputDecoration(
                    labelText: 'Difficulté *',
                    prefixIcon: Icon(Icons.local_fire_department),
                  ),
                  items: [
                    for (final d in Difficulty.values)
                      DropdownMenuItem(value: d, child: Text(d.label)),
                  ],
                  onChanged: (v) => setState(() => _difficulty = v!),
                ),
                const SizedBox(height: 14),
                TextFormField(
                  controller: _ingredientsController,
                  minLines: 3,
                  maxLines: 6,
                  decoration: const InputDecoration(
                    labelText: 'Ingrédients * (un par ligne)',
                    hintText: '500 g de bœuf\n3 oignons\n…',
                    alignLabelWithHint: true,
                    prefixIcon: Icon(Icons.list_alt),
                  ),
                  validator: (v) =>
                      _validateLines(v, 'La liste d\u2019ingrédients', 2),
                ),
                const SizedBox(height: 14),
                TextFormField(
                  controller: _stepsController,
                  minLines: 3,
                  maxLines: 8,
                  decoration: const InputDecoration(
                    labelText: 'Étapes de préparation * (une par ligne)',
                    hintText: 'Faire revenir les oignons…\nAjouter la viande…',
                    alignLabelWithHint: true,
                    prefixIcon: Icon(Icons.format_list_numbered),
                  ),
                  validator: (v) => _validateLines(v, 'La liste des étapes', 1),
                ),
                const SizedBox(height: 14),
                TextFormField(
                  controller: _descriptionController,
                  minLines: 2,
                  maxLines: 4,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: const InputDecoration(
                    labelText: 'Description (optionnel)',
                    alignLabelWithHint: true,
                    prefixIcon: Icon(Icons.notes),
                  ),
                ),
                const SizedBox(height: 24),
                FilledButton.icon(
                  style: FilledButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                  ),
                  onPressed: _saving ? null : _submit,
                  icon: _saving
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.check),
                  label: Text(
                    _saving ? 'Enregistrement…' : 'Publier la recette',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
