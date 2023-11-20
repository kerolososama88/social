import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/screens/register/cubit/register_statse.dart';
import '../../../constans/constans_buttom.dart';
import '../../../style/custome_color.dart';
import '../cubit/register_cubit.dart';

// ignore: must_be_immutable
class RegisterScreen extends StatelessWidget {
   RegisterScreen({super.key});
  var formKey = GlobalKey<FormState>();
  var emailConteroller = TextEditingController();
  var passwordConteroller = TextEditingController();
  var namedConteroller = TextEditingController();
  var phoneConteroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
  create: (context) => RegisterCubit(RegisterInitalState()),
  child: BlocConsumer<RegisterCubit, RegisterState>(
  listener: (context, state) {
    if(state is RegisterCreateUserErrorState)
   {
     showToast(text: state.error, state: ToastState.ERROR);
   }
  },
  builder: (context, state) {
    return Scaffold(
      appBar: AppBar(),
      body:  Center(
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'REGISTER',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  Text(
                    'Register now to communicate with friends',
                    style:
                    Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.name,
                    controller: namedConteroller,
                    decoration: const InputDecoration(
                      label: Text('User Name'),
                      prefix: Icon(Icons.person),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your name address';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: emailConteroller,
                    decoration: const InputDecoration(
                      label: Text('Email Address'),
                      prefix: Icon(Icons.email),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your emil address';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    controller: passwordConteroller,
                    obscureText: RegisterCubit.get(context).isPassword
                        ? true
                        : false,
                    decoration: InputDecoration(
                      label: const Text('Password'),
                      prefix: const Icon(Icons.lock),
                      suffix: RegisterCubit.get(context).suffixWidget(),
                    ),
                    onFieldSubmitted: (value) {},
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Password is too short';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.phone,
                    controller: phoneConteroller,
                    decoration: const InputDecoration(
                      label: Text('Phone'),
                      prefix: Icon(Icons.phone),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your phone number';
                      }
                      return null;

                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  ConditionalBuilder(
                    condition: state is! RegisterLoadinglState,
                    builder: (context) => defaultButtom(
                      function: () {
                        if (formKey.currentState!.validate()) {
                          RegisterCubit.get(context).userRegister(
                            context: context,
                            email: emailConteroller.text,
                            password: passwordConteroller.text,
                            name: namedConteroller.text,
                            phone: phoneConteroller.text,
                          );
                        }
                      },
                      color: Colors.white,
                      text: 'Register',
                      background: defaultColor, width: double.infinity,
                    ),
                    fallback: (context) =>
                    const Center(child: CircularProgressIndicator()),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  },
),
);
  }
}
